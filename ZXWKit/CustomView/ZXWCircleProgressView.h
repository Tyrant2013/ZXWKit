//
//  ZXWCircleProgressView.h
//  KKitTestDemo
//
//  Created by 庄晓伟 on 16/2/15.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZXWCircleProgressView : UIView

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat circleStrokeWidth;
@property (nonatomic, strong) UIColor *circleStrokeColor;
@property (nonatomic, strong) UIColor *circleBackgroundColor;

@end
