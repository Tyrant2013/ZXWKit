//
//  ZXWScanFramView.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/3/3.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZXWScanFrameView : UIView

@property (nonatomic, assign) CGRect scanFrame;

- (id)initWithFrame:(CGRect)frame scanFram:(CGRect)scanFrame;
- (void)startAnimation;
- (void)stopAnimation;

@end
