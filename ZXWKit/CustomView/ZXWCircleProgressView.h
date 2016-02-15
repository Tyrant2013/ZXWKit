//
//  ZXWCircleProgressView.h
//  KKitTestDemo
//
//  Created by 庄晓伟 on 16/2/15.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWCircleProgressView : UIView

@property (nonatomic, assign) CGFloat                           progress;
@property (nonatomic, assign) CGFloat                           strokeWidth;
@property (nonatomic, strong) UIColor                           *strokeColor;
@property (nonatomic, strong) UIColor                           *backgroundColor;

@end
