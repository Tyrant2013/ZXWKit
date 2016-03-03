//
//  ZXWScanView.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/3/3.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CaptureResult)(NSString *captureMsg);

@interface ZXWScanView : UIView

- (id)initWithFrame:(CGRect)frame captureResult:(CaptureResult)complete;
- (void)startCapture;
- (void)stopCapture;

@end
