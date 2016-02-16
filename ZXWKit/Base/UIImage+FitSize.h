//
//  UIImage+FitSize.h
//  AutoLearning
//
//  Created by 庄晓伟 on 16/2/16.
//  Copyright © 2016年 Zhuhai Auto-Learning Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FitSize)

///  处理像素对齐的问题
- (UIImage *)zxw_fitSize:(CGSize)size;

@end
