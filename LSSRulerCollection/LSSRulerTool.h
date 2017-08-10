//
//  LSSRulerTool.h
//  LSSRulerCollection
//
//  Created by lss on 2017/3/7.
//  Copyright © 2017年 liuss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSSRulerConst.h"
@interface LSSRulerTool : NSObject
#pragma mark - 视频数据数组模型
@property(nonatomic,copy)NSString *startTime;//视频开始时间
@property(nonatomic,copy)NSString *endTime;//视频结束时间
@property(nonatomic,copy)NSString *NvrUrl;//视频地址

#pragma mark - Date Time 函数
+(NSString *)getTimeByDate:(NSDate *)date FormatStr:(NSString *)formatStr;
+(NSString *)getTimeStrByDate:(NSDate *)date;
+(NSString *)getTimeStrByDateDay:(NSDate *)date;
+(NSDate *)getDateByTimeStr:(NSString *)timeStr;
+(NSString *)HowManyHoursAgoWith:(float)hours;
@end
