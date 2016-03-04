//
//  ZXWPlaceHolderTextView.h
//  ZXWKitTestDemo
//
//  Created by 庄晓伟 on 16/3/2.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXWPlaceHolderTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString                      *placeHolder;
@property (nonatomic, strong) IBInspectable UIColor                     *placeHolderColor;

@end
