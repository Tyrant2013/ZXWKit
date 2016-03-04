//
//  UIControl+Track.m
//  AutoLearning
//
//  Created by 庄晓伟 on 15/12/2.
//  Copyright © 2015年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import <objc/message.h>
#import <UIKit/UIKit.h>


@implementation UIControl (Track)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self changeMethod];
    });
#endif
}

+ (void)changeMethod {
    Class class = [self class];
    SEL originalSelector = @selector(sendAction:to:forEvent:);
    SEL swizzledSelector = @selector(zxw_sendAction:to:forEvent:);

    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)zxw_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self zxw_sendAction:action to:target forEvent:event];
}

@end
