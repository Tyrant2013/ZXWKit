//
//  ZXWAlertView.h
//  ZXWKitTestDemo
//
//  Created by 庄晓伟 on 16/2/17.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZXWAlertView : UIView

- (id)initWithTitle:(NSString *)title leftButton:(NSString *)leftButton middleButton:(NSString *)middleButton rightButton:(NSString *)rightButton content:(NSString *)content completeWithButtonIndex:(void (^)(NSUInteger index))complete;
- (void)show;

@end
