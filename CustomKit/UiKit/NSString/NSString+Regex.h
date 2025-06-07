//
//  NSString+Regex.h
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Regex)

/**是否匹配手机号码(中国电信、中国移动、中国联通)*/
- (BOOL) isMatchMobileNumberStr;

/**是否匹配中国移动手机号码*/
- (BOOL) isMatchMobileNumForChinaMobileStr;

/**是否匹配中国联通手机号码*/
- (BOOL)isMatchMobileNumForChinaUnicomStr;

/**是否匹配中国电信手机号码*/
- (BOOL)isMatchMobileNumForChinaTelecomStr;

/**是否匹配陆地区固话及小灵通号码*/
- (BOOL)isMatchFixedTelephoneNumberStr;

/**验证邮箱*/
- (BOOL)isValidateEmail;

/**是否纯数字*/
- (BOOL)isMatchFixedNumberStr;

/// 是否包含英文
- (BOOL)isHaveLetter;

/// 是否含有数字
- (BOOL)isHaveNumberStr;

/**是否匹配身份证*/
- (BOOL)isIdCard;

/**判空*/
- (BOOL)isEmpty;

///是不是中文
- (BOOL)isChinese;

///是不是英文大写
- (BOOL)isEnglish;

- (BOOL)isEmoji;

+ (BOOL)checkUrlWithString:(NSString *)url;

- (NSArray*)getURL;

- (NSString*)attributedStringWithHTMLString:(NSString*)htmlString;

- (BOOL)hasChinese;

- (NSArray *)getMart;

@end

NS_ASSUME_NONNULL_END
