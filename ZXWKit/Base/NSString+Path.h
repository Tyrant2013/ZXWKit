//
//  NSString+Path.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/28.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIBezierPath;
@class UIFont;


@interface NSString (Path)

- (UIBezierPath *)bezierPathWithFont:(UIFont *)font;

@end
