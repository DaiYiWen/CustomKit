//
//  NSString+Time.m
//  GuiHuaRenSheng
//
//  Created by apple on 2019/5/22.
//  Copyright © 2019 wancaishangwu. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

/**
 时间戳转换时间
 
 @param format 格式
 @param timestamp 时间戳
 @return 返回时间
 */
+ (NSString *)interceptTimeStampFormat:(NSString *)format timestamp:(NSString *)timestamp
{
    
    NSTimeInterval _interval = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    objDateformat.locale = [NSLocale systemLocale];;
    [objDateformat setDateFormat:format];
    
    return [objDateformat stringFromDate: date];
}


/**
 字符串转时间戳
 
 @param format 格式
 @param time 时间
 @return 返回时间戳
 */
+ (NSString *)changeTimestampWithFormat:(NSString *)format time:(NSString *)time
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale systemLocale];
    [formatter setDateFormat:format];
    NSDate *tempDate = [formatter dateFromString:time];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}
//返回当天的23点59分59秒999毫秒
+ (NSString *)changeTimestampWithFormat2:(NSString *)format time:(NSString *)time
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [NSLocale systemLocale];
    [formatter setDateFormat:format];
    NSDate *tempDate = [formatter dateFromString:time];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", ((long)[tempDate timeIntervalSince1970]*1000+24*60*60*1000-1)];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

/**
 时间间隔
 
 @param beTime 时间戳
 @return 返回距今时间
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    
    beTime = beTime/ 1000.0;
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    df.locale = [NSLocale systemLocale];;
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        //        distanceStr = [NSString stringWithFormat:@"今天 %@",timeStr];
        distanceStr = timeStr;
    }
    else if(distanceTime<24*60*60*7 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            //            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
            distanceStr = @"昨天";
        }
        else{
        
            distanceStr = [self weekdayStringFromDate:[NSString stringWithFormat:@"%f",beTime*1000]];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM月dd日"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy年MM月dd"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
}

//传入时间返回星期几
+ (NSString*)weekdayStringFromDate:(NSString *)timestamp
{
    
    NSTimeInterval _interval=[timestamp doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    return [weekdays objectAtIndex:theComponents.weekday];
}

//+ (NSString *)getTimeTodayYesTime:(NSString *)time{
//    NSDate *date = [NSDate dateWithString:time format:@"yyyy-MM-dd HH:mm:ss"];
//    if ([date isToday]) {
//        return ZLanguage(@"taday");
//    }else if([date isYesterday]){
//        return ZLanguage(@"yesterday");
//    }
//    return [date stringWithFormat:@"MM-dd"];
//}
//+ (NSString *)getTimeTodayTimeYesTime:(NSString *)time{
//    NSDate *date = [NSDate dateWithString:time format:@"yyyy-MM-dd HH:mm:ss"];
//    if ([date isToday]) {
//        return [date stringWithFormat:@"HH:mm"];
//    }else if([date isYesterday]){
//        return ZLanguage(@"yesterday");
//    }
//    return [date stringWithFormat:@"MM-dd"];
//}

- (BOOL)isSameDay:(NSString *)day{
    // 创建日期格式化器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    // 将字符串时间转换为NSDate对象
    NSDate *time = [dateFormatter dateFromString:self];

    // 获取当前日期
    NSDate *today = [dateFormatter dateFromString:day];

    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];

    // 比较日期组件的年、月、日是否相同
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *timeComponents = [calendar components:unit fromDate:time];
    NSDateComponents *todayComponents = [calendar components:unit fromDate:today];

    if (timeComponents.year == todayComponents.year &&
      timeComponents.month == todayComponents.month &&
      timeComponents.day == todayComponents.day) {
        return true;
    } else {
        return false;
    }
}
+ (NSDate *)dateSystemWithString:(NSString *)dateString format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [NSLocale systemLocale];
    [formatter setDateFormat:format];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [formatter dateFromString:dateString];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    return [formatter dateFromString:dateString];
}

@end
