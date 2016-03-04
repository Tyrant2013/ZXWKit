//
//  ZXWAlertView.m
//  ZXWKitTestDemo
//
//  Created by 庄晓伟 on 16/2/17.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWAlertView.h"

static NSUInteger const kButtonLeftIndex = 1;
static NSUInteger const kButtonMiddleIndex = 2;
static NSUInteger const kButtonRightIndex = 3;
static CGFloat const kButtonHeight = 50.0f;
static CGFloat const kButtonWidthMultiplier = 0.5f;
static CGFloat const kButtonTitleSize = 20.0f;
static CGFloat const kTitleFontSize = 20.0f;
static CGFloat const kAlertViewCornerRadius = 20.0f;
static CGFloat const kAlertViewMargin = 50.0f;


@interface ZXWAlertView ()

@property (nonatomic, copy) void (^complete)(NSUInteger index);
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *leftButtonTitle;
@property (nonatomic, copy) NSString *middleButtonTitle;
@property (nonatomic, copy) NSString *rightButtonTitle;
@property (nonatomic, strong) UIWindow *showWindow;
@property (nonatomic, weak) UILabel *contentLabel;

@end


@implementation ZXWAlertView

- (id)initWithTitle:(NSString *)title leftButton:(NSString *)leftButton middleButton:(NSString *)middleButton rightButton:(NSString *)rightButton content:(NSString *)content completeWithButtonIndex:(void (^)(NSUInteger))complete {
    if (self = [super init]) {
        self.complete = complete;
        self.title = title;
        self.content = content;
        self.leftButtonTitle = leftButton;
        self.middleButtonTitle = middleButton;
        self.rightButtonTitle = rightButton;
        [self setupSubviews];
        self.layer.cornerRadius = kAlertViewCornerRadius;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setupSubviews {
    [self setupTitleLabel];
    [self setupContentLabel];
    [self setupLeftButton];
    //    [self setupMiddleButton];
    [self setupRightButton];
}

- (void)setupTitleLabel {
    if (self.title) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.title;
        label.font = [UIFont systemFontOfSize:kTitleFontSize];
        label.textColor = [UIColor darkTextColor];
        label.textAlignment = NSTextAlignmentCenter;
        [label sizeToFit];
        [self addSubview:label];

        NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(label)];
        NSArray *v = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(label)];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:h];
        [self addConstraints:v];
    }
}

- (void)setupContentLabel {
    UILabel *label = [[UILabel alloc] init];
    label.text = self.content;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.textColor = [UIColor darkTextColor];
    label.textAlignment = NSTextAlignmentLeft;
    [label sizeToFit];
    [self addSubview:label];
    self.contentLabel = label;

    NSArray *h = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:NSDictionaryOfVariableBindings(label)];
    NSArray *v = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[label]" options:NSLayoutFormatAlignAllTop metrics:nil views:NSDictionaryOfVariableBindings(label)];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:h];
    [self addConstraints:v];
}

- (void)setupLeftButton {
    if (self.leftButtonTitle) {
        UIButton *button = [self buttonWithTitle:self.leftButtonTitle];
        button.tag = kButtonLeftIndex;
        [self addSubview:button];

        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:kButtonWidthMultiplier constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonHeight];
        NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:10];

        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addConstraint:height];
        [self addConstraints:@[ bottom, lead, width, top ]];
    }
}

- (void)setupMiddleButton {
    if (self.middleButtonTitle) {
        UIButton *button = [self buttonWithTitle:self.middleButtonTitle];
        button.tag = kButtonMiddleIndex;
        [self addSubview:button];

        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:kButtonWidthMultiplier constant:0];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonHeight];

        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addConstraint:height];
        [self addConstraints:@[ bottom, centerX, width ]];
    }
}

- (void)setupRightButton {
    if (self.rightButtonTitle) {
        UIButton *button = [self buttonWithTitle:self.rightButtonTitle];
        button.tag = kButtonRightIndex;
        [self addSubview:button];

        CGFloat offset = 1.0f / [UIScreen mainScreen].scale;
        NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
        NSLayoutConstraint *trail = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
        NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:kButtonWidthMultiplier constant:offset];
        NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonHeight];

        button.translatesAutoresizingMaskIntoConstraints = NO;
        [button addConstraint:height];
        [self addConstraints:@[ bottom, trail, width ]];
    }
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    button.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleSize];
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.borderWidth = 1.0f;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)show {
    _showWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _showWindow.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    _showWindow.windowLevel = UIWindowLevelAlert;

    _showWindow.hidden = NO;
    [_showWindow addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapGesture:)];

        tap;
    })];

    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderWidth = 1.0f / [UIScreen mainScreen].scale;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [_showWindow addSubview:self];
    [self setupLayoutConstrait];
}

- (void)setupLayoutConstrait {
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.showWindow attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *lead = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.showWindow attribute:NSLayoutAttributeLeading multiplier:1 constant:kAlertViewMargin];
    NSLayoutConstraint *trail = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.showWindow attribute:NSLayoutAttributeTrailing multiplier:1 constant:-kAlertViewMargin];

    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.showWindow addConstraints:@[ centerY, lead, trail ]];
}

- (void)tapGesture:(UITapGestureRecognizer *)sender {
    [self removeFromSuperview];
    self.showWindow.hidden = YES;
    self.showWindow = nil;
}

- (void)buttonClick:(UIButton *)sender {
    [self removeFromSuperview];
    self.showWindow.hidden = YES;
    self.showWindow = nil;

    if (self.complete) {
        self.complete(sender.tag);
    }
}

@end
