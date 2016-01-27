//
//  WebViewJSBridge.h
//  AutoLearning
//
//  Created by 庄晓伟 on 15/12/24.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

//  用于实现WebView里JavaScript 与 本地代码互调
//  通过修改页面上的JavaScript实现，页面上的代码就不需要另外做判断了

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebViewJSBridge : NSObject <UIWebViewDelegate>

@property (nonatomic, weak) UIWebView                           *webView;

+ (instancetype)bridgeForWebView:(UIWebView*)webView webViewDelegate:(NSObject<UIWebViewDelegate>*)webViewDelegate;
+ (instancetype)bridgeForWebView:(UIWebView*)webView webViewDelegate:(NSObject<UIWebViewDelegate>*)webViewDelegate resourceBundle:(NSBundle*)bundle;

- (void)excuteJSWithObj:(NSString *)obj function:(NSString *)function;

@end
