//
//  NSString+Md5.h
//  MaxWellProject
//
//  Created by admin on 2020/4/29.
//  Copyright © 2020 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Md5)
-(NSString *)md5String;
@end

NS_ASSUME_NONNULL_END
