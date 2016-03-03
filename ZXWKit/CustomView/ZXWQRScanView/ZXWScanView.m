//
//  ZXWScanView.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/3/3.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "ZXWScanView.h"
#import "ZXWScanFrameView.h"
#import <AVFoundation/AVFoundation.h>

@interface ZXWScanView() <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession                          *captureSession;
@property (nonatomic, strong) AVCaptureDevice                           *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput                      *captureInput;
@property (nonatomic, strong) AVCaptureMetadataOutput                   *captureOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer                *previewLayer;
@property (nonatomic, strong) ZXWScanFrameView                          *scanFrameView;
@property (nonatomic, copy) CaptureResult                               captureResultBlock;

@end

@implementation ZXWScanView

- (id)initWithFrame:(CGRect)frame {
    if (self = [[[self class] alloc] initWithFrame:frame captureResult:nil]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame captureResult:(CaptureResult)complete {
    if (self = [super initWithFrame:frame]) {
        self.captureResultBlock = complete;
        [self p_setupAVCaptureComponents];
        [self p_configComponents];
        [self p_addScanFrameView];
        [[NSNotificationCenter defaultCenter] addObserverForName:AVCaptureInputPortFormatDescriptionDidChangeNotification
                                                          object:nil
                                                           queue:[NSOperationQueue mainQueue]
                                                      usingBlock:^(NSNotification * _Nonnull note)
         {
             CGRect rectOfInterest = self.scanFrameView.scanFrame;
             self.captureOutput.rectOfInterest = [self.previewLayer metadataOutputRectOfInterestForRect:rectOfInterest];
         }];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    
    if ([metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject * metadataObject = metadataObjects.firstObject;
        stringValue = metadataObject.stringValue;
    }
    
    [self.captureSession stopRunning];
    [self.scanFrameView stopAnimation];
    if (self.captureResultBlock) {
        self.captureResultBlock(stringValue);
    }
}

- (void)p_startCaptureRun {
    if (self.captureSession && !self.captureSession.isRunning) {
        [self.captureSession startRunning];
    }
}

- (void)p_setupAVCaptureComponents {
    _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    _captureInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
    _captureOutput = [[AVCaptureMetadataOutput alloc] init];
    _captureSession = [[AVCaptureSession alloc] init];
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
}

- (void)p_configComponents {
    [self.captureSession addOutput:self.captureOutput];
    
    if (self.captureInput) {
        [self.captureSession addInput:self.captureInput];
    }
    [self.captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    if ([[self.captureOutput availableMetadataObjectTypes] containsObject:AVMetadataObjectTypeQRCode]) {
        [self.captureOutput setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    }
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.bounds;
    [self.layer insertSublayer:self.previewLayer atIndex:0];
}

- (void)p_addScanFrameView {
    [self.scanFrameView removeFromSuperview];
    ZXWScanFrameView *scanView = [[ZXWScanFrameView alloc] initWithFrame:self.bounds];
    [self addSubview:scanView];
    self.scanFrameView = scanView;
}

- (void)startCapture {
    if (self.captureSession && !self.captureSession.isRunning) {
        [self.captureSession startRunning];
    }
}

- (void)stopCapture {
    if (self.captureSession && self.captureSession.isRunning) {
        [self.captureSession stopRunning];
    }
}

@end
