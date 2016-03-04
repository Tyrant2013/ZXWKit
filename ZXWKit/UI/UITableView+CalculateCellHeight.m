//
//  UITableView+CalculateCellHeight.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UITableView+CalculateCellHeight.h"
#import <objc/runtime.h>


@implementation UITableView (CalculateCellHeight)

- (CGFloat)zxw_heightForIdentifier:(NSString *)identifier cacheKey:(NSString *)cahceKey configuration:(void (^)(id cell))configuration {
    if (identifier == nil) {
        return 0.0f;
    }
    UITableViewCell *cell = [self dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        return 0.0f;
    }

    [cell prepareForReuse];

    if (configuration) {
        configuration(cell);
    }

    CGFloat width = CGRectGetWidth(self.bounds);
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1
                                                                        constant:width];
    cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addConstraint:widthConstraint];
    CGFloat height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (NSMutableDictionary *)cacheHeight {
    NSMutableDictionary *data = objc_getAssociatedObject(self, _cmd);
    if (data == nil) {
        data = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return data;
}

@end
