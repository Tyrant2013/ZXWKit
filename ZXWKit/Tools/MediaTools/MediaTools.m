//
//  MediaTools.m
//  ZXWKit
//
//  Created by 庄晓伟 on 16/2/19.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import "MediaTools.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@implementation MediaTools

+ (UIImage *)getFirstFrameOfVideoWithVideoURL:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetIG = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    assetIG.appliesPreferredTrackTransform = YES;
    assetIG.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = 60;
    NSError *igError = nil;
    thumbnailImageRef = [assetIG copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60) actualTime:NULL error:&igError];
    
    if (!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@", igError );
    
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc] initWithCGImage:thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

@end
