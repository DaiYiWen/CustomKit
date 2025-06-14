//
//  NSString+Hash.h
//  MaxWellProject
//
//  Created by admin on 2020/4/29.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#define Salt @"ascscadscadscacasdre239032023"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Hash)
//MD5加密
- (NSString *)digest:(NSString *)str;
//加盐
- (NSString *)digest2:(NSString *)str;
//多次MD5
- (NSString *)digest3:(NSString *)str;
//先加密后乱序
- (NSString *)digest4:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
