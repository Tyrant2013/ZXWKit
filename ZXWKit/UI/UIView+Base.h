//
//  UIView+Base.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/25.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Base)

@property (nonatomic, assign) CGFloat           x;              ///self.frame.origin.x
@property (nonatomic, assign) CGFloat           y;              ///self.frame.origin.y
@property (nonatomic, assign) CGFloat           height;         ///self.frame.size.height
@property (nonatomic, assign) CGFloat           width;          ///self.frame.size.width
@property (nonatomic, assign) CGFloat           bottom;         ///self.frame.origin.y + self.frame.size.height
@property (nonatomic, assign) CGFloat           top;            ///self.frame.origin.y
@property (nonatomic, assign) CGFloat           left;           ///self.frame.origin.x
@property (nonatomic, assign) CGFloat           right;          ///self.frame.origin.x + self.frame.size.width

@end
