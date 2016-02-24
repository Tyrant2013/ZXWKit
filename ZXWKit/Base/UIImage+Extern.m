//
//  UIImage+Extern.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/2/19.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "UIImage+Extern.h"
@import ImageIO;


@implementation UIImage (Extern)

- (void)decodeWithFilePath:(NSString *)filePath
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:filePath];

        [self decodeWithData:data];
    });
}

- (void)decodeWithData:(NSData *)data
{
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    if (src) {
        // 获取Gif的帧数
        NSUInteger frameCount = CGImageSourceGetCount(src);
        // 获取Gif的基本数据
        NSDictionary *gifProperties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyProperties(src, NULL));
        if (gifProperties) {
            // 由Gif的基本数据获取Gif数据
            NSDictionary *gifDictonary = [gifProperties objectForKey:(NSString *)kCGImagePropertyGIFDictionary]; // 获取gif的播放次数
            NSUInteger loopCount = [[gifDictonary objectForKey:(NSString *)kCGImagePropertyGIFLoopCount] integerValue];
            NSLog(@"loopCount : %@", @(loopCount));
            for (NSUInteger i = 0; i < frameCount; ++i) {
                // 得到每一帧的CGImage
                CGImageRef img = CGImageSourceCreateImageAtIndex(src, (size_t)i, NULL);
                if (img) {
                    // 把CGImage转化为UIImage
                    UIImage *frameImage = [UIImage imageWithCGImage:img];
                    NSLog(@"%@", frameImage);
                    // 获取每一帧的图片信息
                    NSDictionary *frameProperties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, (size_t)img, NULL));
                    if (frameProperties) {
                        // 由每一帧的图片信息获取Gif信息
                        NSDictionary *frameDictionary = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
                        // 取出每一帧的delaytime
                        NSTimeInterval delayTime = [[frameDictionary objectForKey:(NSString *)kCGImagePropertyGIFDelayTime] timeInterval];
                        NSLog(@"delayTime : %@", @(delayTime));

                        CFRelease((__bridge CFTypeRef)(frameProperties));
                    }
                    CGImageRelease(img);
                }
            }
            CFRelease((__bridge CFTypeRef)(gifProperties));
        }
        CFRelease(src);
    }
}

- (UIImage *)zxw_imageWithRoundedCornersAndSize:(CGSize)size cornerRaidus:(CGFloat)radius
{
    CGRect rect = (CGRect){0.f, 0.f, size};

    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context,
                     [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    CGContextClip(context);

    [self drawInRect:rect];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return output;
}

@end
