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

@end

NS_ASSUME_NONNULL_END
