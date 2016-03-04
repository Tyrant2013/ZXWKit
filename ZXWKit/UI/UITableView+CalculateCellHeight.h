//
//  UITableView+CalculateCellHeight.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (CalculateCellHeight)

- (CGFloat)zxw_heightForIdentifier:(NSString *)identifier cacheKey:(NSString *)cahceKey configuration:(void (^)(id cell))configuration;

@end
