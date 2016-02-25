//
//  WebViewJSBridge.m
//  AutoLearning
//
//  Created by 庄晓伟 on 15/12/24.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import "WebViewJSBridge.h"
#import <objc/runtime.h>

static NSString *const kCustomProtocolScheme = @"calloc";
static NSString *const kJavaScriptExternalName = @"external";
static NSString *const kTrueString = @"true";
static NSString *const kInjectionJSFileName = @"WebViewJSBridge";
static NSString *const kInjectionJSFileExternal = @"js";

static NSString *const kPoint = @".";
static NSString *const kPreQuotation = @"\"";
static NSString *const kLastQuotation = @"\",";
static NSString *const kColon = @":";
static NSString *const kEmpty = @"";


@interface WebViewJSBridge ()

@property (nonatomic, weak) id webViewDelegate;
@property (nonatomic, weak) NSBundle *resourceBundle;

@end


@implementation WebViewJSBridge

+ (instancetype)bridgeForWebView:(UIWebView *)webView webViewDelegate:(NSObject<UIWebViewDelegate> *)webViewDelegate {
    return [self bridgeForWebView:webView webViewDelegate:webViewDelegate resourceBundle:nil];
}

+ (instancetype)bridgeForWebView:(UIWebView *)webView webViewDelegate:(NSObject<UIWebViewDelegate> *)webViewDelegate resourceBundle:(NSBundle *)bundle {
    WebViewJSBridge *bridge = [[[self class] alloc] init];
    [bridge _platformSpecificSetup:webView webViewDelegate:webViewDelegate resourceBundle:bundle];
    return bridge;
}

#pragma mark -
#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (webView != _webView) {
        return;
    }
    // 页面加载完成后，注入一段JavaScript，修改当前页面上所有的function，使方法被Native Code捕获
    NSString *JSString = [NSString stringWithFormat:@"typeof window.%@ == 'object'", kJavaScriptExternalName];
    if (![[webView stringByEvaluatingJavaScriptFromString:JSString] isEqualToString:kTrueString]) {
        //获取需要被注入的方法，当前类的方法列表
        uint methodCount = 0;
        Method *methods = class_copyMethodList([self class], &methodCount);
        NSMutableString *methodList = [NSMutableString string];
        for (NSUInteger index = 0; index < methodCount; ++index) {
            const char *selName = sel_getName(method_getName(methods[index]));
            NSString *methodName = [NSString stringWithCString:selName
                                                      encoding:NSUTF8StringEncoding];
            //防止隐藏的系统方法名包含“.”导致js报错
            if ([methodName rangeOfString:kPoint].location != NSNotFound) {
                continue;
            }
            [methodList appendString:kPreQuotation];
            [methodList appendString:[methodName stringByReplacingOccurrencesOfString:kColon withString:kEmpty]];
            [methodList appendString:kLastQuotation];
        }

        if (methodList.length > 0) {
            [methodList deleteCharactersInRange:NSMakeRange(methodList.length - 1, 1)];
        }

        free(methods);
        /// 加载要注入的代码，并运行
        NSBundle *bundle = _resourceBundle ? _resourceBundle : [NSBundle mainBundle];
        NSString *filePath = [bundle pathForResource:kInjectionJSFileName ofType:kInjectionJSFileExternal];
        NSString *JavaScriptBlock = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:JavaScriptBlock, methodList]];
    }

    __strong typeof(_webViewDelegate) strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [strongDelegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (webView != _webView) {
        return;
    }

    __strong typeof(_webViewDelegate) strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [strongDelegate webView:webView didFailLoadWithError:error];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (webView != _webView) {
        return YES;
    }
    NSURL *url = [request URL];
    __strong typeof(_webViewDelegate) strongDelegate = _webViewDelegate;

    NSString *requestString = [[request URL] absoluteString];
    if ([requestString hasPrefix:kCustomProtocolScheme]) {
        NSArray *components = [[url absoluteString] componentsSeparatedByString:kColon];

        NSString *function = (NSString *)[components objectAtIndex:1];
        NSString *argsAsString = [(NSString *)[components objectAtIndex:2] stringByRemovingPercentEncoding];

        NSArray *args = [self p_covertToNSArrayFromJSArray:argsAsString];

#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        SEL selector = NSSelectorFromString([args count] > 0 ? [function stringByAppendingString:kColon] : function);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:args];
        }
        return NO;
    } else if (strongDelegate && [strongDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        return [strongDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    } else {
        return YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (webView != _webView) {
        return;
    }

    __strong typeof(_webViewDelegate) strongDelegate = _webViewDelegate;
    if (strongDelegate && [strongDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [strongDelegate webViewDidStartLoad:webView];
    }
}

- (NSArray *)p_covertToNSArrayFromJSArray:(NSString *)argsString {
    NSData *argsData = [argsString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *argsDic = [NSJSONSerialization JSONObjectWithData:argsData options:NSJSONReadingAllowFragments error:&error];
    if (!error) {
        NSMutableArray *args = @[].mutableCopy;
        for (NSUInteger index = 0; index < argsDic.count; ++index) {
            NSString *key = [NSString stringWithFormat:@"%ld", index];
            id arg = argsDic[key];
            [args addObject:arg];
        }
        return args.copy;
    }
    return nil;
}

#pragma mark -
#pragma mark - Excute JavaScript Method

- (void)excuteJSWithObj:(NSString *)obj function:(NSString *)function {
    NSString *js = function;
    if (obj) {
        js = [NSString stringWithFormat:@"%@.%@", obj, function];
    }
    [self.webView stringByEvaluatingJavaScriptFromString:js];
}

#pragma mark -
#pragma mark - Init & Dealloc

- (void)_platformSpecificSetup:(UIWebView *)webView
               webViewDelegate:(id<UIWebViewDelegate>)webViewDelegate
                resourceBundle:(NSBundle *)bundle {
    _webView = webView;
    _webViewDelegate = webViewDelegate;
    _webView.delegate = self;
    _resourceBundle = bundle;
}

- (void)dealloc {
    _webView.delegate = nil;
    _webView = nil;
    _webViewDelegate = nil;
}

@end
