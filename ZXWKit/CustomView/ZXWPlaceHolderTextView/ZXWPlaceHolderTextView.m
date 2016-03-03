//
//  ZXWPlaceHolderTextView.m
//  ZXWKitTestDemo
//
//  Created by 庄晓伟 on 16/3/2.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWPlaceHolderTextView.h"

@interface ZXWPlaceHolderTextView()

@property (nonatomic, weak) UILabel                                     *placeHolderLabel;

@end

@implementation ZXWPlaceHolderTextView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_setupPlaceHolder];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self p_setupPlaceHolder];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.placeHolderLabel.frame;
    frame.origin.y = 8;
    frame.origin.x = 5;
    frame.size.width = CGRectGetWidth(frame) - CGRectGetMinX(frame) * 2;
    self.placeHolderLabel.frame = frame;
    
//    self.placeHolderLabel.y = 8; //设置UILabel 的 y值
//    
//    self.placeHolderLabel.x = 5;//设置 UILabel 的 x 值
//    
//    self.placeHolderLabel.width = self.width-self.placeHolderLabel.x*2.0; //设置 UILabel 的 x
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(CGRectGetWidth(frame), MAXFLOAT);
    
    frame.size.height = [self.placeHolder boundingRectWithSize:maxSize
                                                                 options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                              attributes:@{NSFontAttributeName : self.placeHolderLabel.font}
                                                                 context:nil].size.height;
    self.placeHolderLabel.frame = frame;
    
}

- (void)p_setupPlaceHolder {
    self.backgroundColor= [UIColor clearColor];
    
    UILabel *placeholderLabel = [[UILabel alloc]init];//添加一个占位label
    
    placeholderLabel.backgroundColor= [UIColor clearColor];
    
    placeholderLabel.numberOfLines=0; //设置可以输入多行文字时可以自动换行
    
    [self addSubview:placeholderLabel];
    
    self.placeHolderLabel= placeholderLabel; //赋值保存
    
    self.placeHolderColor= [UIColor lightGrayColor]; //设置占位文字默认颜色
    
    self.font= [UIFont systemFontOfSize:15]; //设置默认的字体
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self]; //通知:监听文字的改变
}

#pragma mark - Notification Response

- (void)textDidChange {
    self.placeHolderLabel.hidden = self.hasText;
}

#pragma mark - Override

- (void)setPlaceHolder:(NSString*)placeHolder{
    
    _placeHolder= [placeHolder copy];
    
    //设置文字
    
    self.placeHolderLabel.text= placeHolder;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}

- (void)setPlaceHolderColor:(UIColor*)placeHolderColor{
    
    _placeHolderColor= placeHolderColor;
    
    //设置颜色
    
    self.placeHolderLabel.textColor= placeHolderColor;
    
}

- (void)setFont:(UIFont*)font {
    
    [super setFont:font];
    
    self.placeHolderLabel.font= font;
    
    //重新计算子控件frame
    
    [self setNeedsLayout];
    
}

- (void)setText:(NSString*)text{
    
    [super setText:text];
    
    [self textDidChange]; //这里调用的就是 UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)setAttributedText:(NSAttributedString*)attributedText {
    
    [super setAttributedText:attributedText];
    
    [self textDidChange]; //这里调用的就是UITextViewTextDidChangeNotification 通知的回调
    
}

- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:UITextViewTextDidChangeNotification];
    
}

@end
