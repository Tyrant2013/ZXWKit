//
//  MediaTools.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/2/19.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface MediaTools : NSObject

+ (UIImage *)getFirstFrameOfVideoWithVideoURL:(NSURL *)videoURL;

@end
