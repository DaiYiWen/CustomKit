//
//  NSString+Md5.m
//  MaxWellProject
//
//  Created by admin on 2020/4/29.
//  Copyright © 2020 admin. All rights reserved.
//

#import "NSString+Md5.h"

@implementation NSString (Md5)

/** md5 一般加密 */
-(NSString *)md5String{
    const char *myPasswd = self.UTF8String;
    unsigned char mdc[16];
    CC_MD5(myPasswd, (CC_LONG)strlen(myPasswd), mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i< 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]];
    }
    return md5String;
}

@end
