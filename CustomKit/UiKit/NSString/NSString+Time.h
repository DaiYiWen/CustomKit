//
//  NSString+Time.h
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Time)
/**
 时间戳转换时间
 
 @param format 格式
 @param timestamp 时间戳
 @return 返回时间
 */
+ (NSString *)interceptTimeStampFormat:(NSString *)format timestamp:(NSString *)timestamp;
/**
 字符串转时间戳
 
 @param format 格式
 @param time 时间
 @return 返回时间戳
 */
+ (NSString *)changeTimestampWithFormat:(NSString *)format time:(NSString *)time;

+ (NSString *)changeTimestampWithFormat2:(NSString *)format time:(NSString *)time;
/**
 时间间隔
 
 @param beTime 时间戳
 @return 返回距今时间
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

/**
 传入时间返回星期几

 @param timestamp 时间
 @return 返回星期几
 */
+ (NSString*)weekdayStringFromDate:(NSString *)timestamp;

//今天，昨天，时间
+ (NSString *)getTimeTodayYesTime:(NSString *)time;

+ (NSString *)getTimeTodayTimeYesTime:(NSString *)time;

- (BOOL)isSameDay:(NSString *)day;

- (NSDate *)systemTimeZone;

+ (NSDate *)dateSystemWithString:(NSString *)dateString format:(NSString *)forma;


/**
 *  时间戳判断
 */
+ (BOOL)isTimestampString:(NSString *)input;

/**
 *  根据时间戳和格式返回当前时间
 */
+ (NSString *)dateStringWithTimeStamp:(NSString *)timeStamp Format:(NSString *)format;

/**
 *  返回距离当前时间过去多久
 */
+ (NSString *)timeAgoSinceDate:(NSDate *)date;



/**
 *  传入字典返回某个key值
 */
//NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
//{
//    @try {
//        id temp = [dic objectForKey:key];
//        if ([temp isKindOfClass:[NSString class]])
//        {
//            if (![temp length]) {
//                return nil;
//            }
//            return [NSString stringWithFormat:@"%@",temp];
//        }
//        else if ([temp isKindOfClass:[NSNumber class]])
//        {
//            return [NSString stringWithFormat:@"%@",[temp stringValue]];
//        }
//    }
//    @catch (NSException *exception) {
//        return nil;
//    }
//    return nil;
//}

@end

NS_ASSUME_NONNULL_END
