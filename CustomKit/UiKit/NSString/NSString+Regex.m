//
//  NSString+Regex.m
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

//是否匹配手机号码(中国电信、中国移动、中国联通)
- (BOOL) isMatchMobileNumberStr
{

    NSString *pattern = @"^((13[0-9])|(14([5]|[7]|[9]))|(15([0-3]|[5-9]))|(166)|(17([0-1]|[3]|[5-8]))|(18[0-9])|(19[8-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//是否匹配中国移动手机号码
- (BOOL) isMatchMobileNumForChinaMobileStr
{
    
    NSString *pattern = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])|47\\d)\\d{7}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//是否匹配中国联通手机号码
- (BOOL) isMatchMobileNumForChinaUnicomStr
{
    
    NSString *pattern = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//是否匹配中国电信手机号码
- (BOOL) isMatchMobileNumForChinaTelecomStr
{
    
    NSString *pattern = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//是否匹配陆地区固话及小灵通号码
- (BOOL) isMatchFixedTelephoneNumberStr
{

    NSString *pattern = @"^(([0-9]{3,4})|([0-9]{3,4})-)?[0-9]{7,8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 是否纯数字
- (BOOL) isMatchFixedNumberStr
{
    
    NSString *pattern = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 是否包含数字
- (BOOL) isHaveNumberStr
{
    NSString *pattern = @".*[0-9]{1,}.*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 是否包含字母
- (BOOL) isHaveLetter{
    NSString *match = @".*[a-zA-Z]{1,}.*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

// 是否身份证
- (BOOL) isIdCard
{
    
    NSString *pattern = @"^\\d{15}(\\d{2}[0-9xX])?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//验证邮箱
-(BOOL)isValidateEmail
{
    NSString *pattern = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    return isMatch;
}

/**判空*/
- (BOOL)isEmpty
{
    //字符串为空 返回YES
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([self isEqualToString:@"{}"]) {
        return YES;
    }

    //不为空 返回NO
    return NO;
}

///是不是中文
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (BOOL)hasChinese{
    for(int i=0; i< [self length];i++){
        int a =[self characterAtIndex:i];
        if( a >0x4e00 && a <0x9fff){
            return YES;
        }
    }
    return NO;
}
- (BOOL) isEnglish{
    NSString *match = @"(^[a-zA-Z]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (BOOL)isEmoji{
    // 确保字符不为空
    if (self.length <= 0) {
        return NO;
    }
    // 确保字符为单字符
    __block BOOL isSingalString = YES;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop)
     {
        if (substringRange.location > 0) {
            isSingalString = NO;
            *stop = YES;
        }
    }];
    if (!isSingalString) {
        return NO;
    }
    // 取一个 UTF-16 单元即前两个字节判断是否为 UTF-32 编码
    const unichar hs = [self characterAtIndex:0];
    if (0xd800 <= hs && hs <= 0xdbff) {
        // 对 UTF-32 格式编码进行码点转换
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const unsigned long long codepoint = (((unsigned long long)hs - 0xd800) * 0x400) + ((unsigned long long)ls - 0xdc00) + 0x10000;
            // 码点模糊匹配
            if (0x1d000 <= codepoint && codepoint <= 0x1faff) {
                return YES;
            } else {
                return NO;
            }
        } else {
            return NO;
        }
    } else {
        // UTF-16 格式的 Emoji 枚举
        if (0x2100 <= hs && hs <= 0x278a) {
            return YES;
        } else if (0x2793 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2b05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2b1b <= hs && hs <= 0x2b1c) {
            return YES;
        } else if (0x2b50 == hs) {
            return YES;
        } else if (0x2b55 == hs) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3030 == hs) {
            return YES;
        } else if (0x303d == hs) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xae) {
            return YES;
        } else if (hs == 0xae) {
            return YES;
        } else {
            return NO;
        }
    }
}

+ (BOOL)checkUrlWithString:(NSString *)url {
//    if(url.length < 1)
//        return NO;
//    if (url.length>4 && [[url substringToIndex:4] isEqualToString:@"www."]) {
//        url = [NSString stringWithFormat:@"http://%@",url];
//    } else {
//        url = url;
//    }
    NSString *urlRegex = @"([a-zA-z]+://[^s]*)";

    NSPredicate* urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];

    return [urlTest evaluateWithObject:url];
}
//- (NSArray*)getURL{
//    NSError *error;
//    //可以识别url的正则表达式
//    NSString *regulaStr = @"((https?|ftp|file):\\/\\/|www.)[-A-Za-z0-9+&@#\\/%?=~_|!:,.;]+[\\u4e00-\\u9fa5-A-Za-z0-9+&@#\\/%=~_|]+|u.me/joinchat/[0-9\\/]+/[a-zA-Z0-9]{8}";
//    if([MatrixShareInstance shareInsatance].domain){
//        regulaStr = [regulaStr stringByAppendingFormat:@"+|#.{1,18}:%@",[MatrixShareInstance shareInsatance].domain];
//    }
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
//    options:NSRegularExpressionCaseInsensitive
//    error:&error];
//
//    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
//
//    //NSString *subStr;
//    NSMutableArray *arr=[[NSMutableArray alloc] init];
//
//    for (NSTextCheckingResult *match in arrayOfAllMatches){
//        NSString* substringForMatch;
//        substringForMatch = [self substringWithRange:match.range];
//        [arr addObject:substringForMatch];
//    }
//    return arr;
//}
//- (NSArray *)getMart{
//    NSError *error;
//    //可以识别url的正则表达式
//    NSString *regulaStr = StrFromObjFormat(@"#.{1,18}:%@",[MatrixShareInstance shareInsatance].domain);
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
//                                                                           options:NSRegularExpressionCaseInsensitive
//                                                                           error:&error];
//    if (error) {
//        // 处理错误
//        NSLog(@"正则表达式创建失败: %@", error.localizedDescription);
//    } else {
//        NSArray *matches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
//        if ([matches count] > 0) {
//            return matches;
//        }
//    }
//    return nil;
//}


- (NSString*)attributedStringWithHTMLString:(NSString*)htmlString {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute :NSHTMLTextDocumentType,

    NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };

    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];

    NSAttributedString *string = [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];

    return string.string;

}
@end
