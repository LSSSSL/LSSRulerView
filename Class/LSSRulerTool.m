//
//  LSSRulerTool.m
//  LSSRulerCollection
//
//  Created by lss on 2017/3/7.
//  Copyright © 2017年 liuss. All rights reserved.
//

#import "LSSRulerTool.h"

@implementation LSSRulerTool
#pragma mark Time 函数
+(NSString *)getTimeByDate:(NSDate *)date FormatStr:(NSString *)formatStr
{
    if (!date)
        return nil;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatStr];
    
    static NSTimeZone *timeZone=nil;
    if (!timeZone)
        timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [dateFormat setTimeZone:timeZone];
    return [dateFormat stringFromDate:date];
}
+(NSString *)getTimeStrByDate:(NSDate *)date
{
    return [LSSRulerTool getTimeByDate:date FormatStr:@"yyyy/MM/dd HH:mm:ss"];;
}
+(NSString *)getTimeStrByDateDay:(NSDate *)date
{
    return [LSSRulerTool getTimeByDate:date FormatStr:@"HH:mm"];
}
+(NSDate *)getDateByTimeStr:(NSString *)timeStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}
#pragma mark -计算几个小时前的时间是什么时候
+(NSString *)HowManyHoursAgoWith:(float)hours{
    NSTimeInterval interval = (kSecond *kSecond*hours);
    NSDate *senddate = [NSDate date];
    NSDate * lastYear = [senddate dateByAddingTimeInterval:-interval];
    NSString *ageTimeStr = [LSSRulerTool getTimeStrByDate:lastYear];
    return ageTimeStr;
}

@end
