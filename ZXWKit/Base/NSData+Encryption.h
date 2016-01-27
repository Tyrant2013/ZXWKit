//
//  NSData+Encryption.h
//  ZXWKit
//
//  Created by 庄晓伟 on 16/1/27.
//  Copyright © 2016年 Elliot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encryption)

- (NSData *)zxw_AES128EncryptedWithKey:(NSString *)key;
- (NSData *)zxw_AES128DecryptedWithKey:(NSString *)key;

@end
