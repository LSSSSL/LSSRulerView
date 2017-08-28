//
//  LSSRulerConst.h
//  LSSRulerCollection
//
//  Created by lss on 2017/3/7.
//  Copyright © 2017年 liuss. All rights reserved.
//

#ifndef LSSRulerConst_h
#define LSSRulerConst_h

#define kRulerDefaultLineColor [UIColor colorWithWhite:0.529 alpha:1.000]
#define kRulerDefaultFillColor [UIColor whiteColor]
#define TheRulerStartTimeValue  @"startTime"
#define TheLenthOfTen         15
#define TheLenthOfTwenty         20
//#define TheLenthOfThirty         30
//#define TheLenthOfForty         40
#define TheLenthOfSeventy        70
#define kSecond                 60

/**
 *  尺子设置值的参考
 *  7天    rulerTime = 720s   maxValue = 840/5=168 格   一大格（五小格）1小时
 *  7天    rulerTime = 12s    maxValue = 50400/5=10080 格   一大格（五小格）1分钟
 *  1天    rulerTime = 720s   maxValue = 120/5 =24 格   一大格（五小格）1小时
 *  1天    rulerTime = 12s    maxValue = 7200/5 =1440 格 一大格（五小格）1分钟
 *  2小时   rulerTime = 12s    maxValue = 600/5 =120 格   一大格（五小格）1分钟
 *  1小时   rulerTime = 12s    maxValue = 300/5 = 30 格   一大格（五小格）1分钟
 */

#define rulerBigSecond       720
#define rulerSmallSecond      12
#define rulerValueSeven      840
#define rulerValueOfDay      120
#define rulerValueOfHour     7200


//判断非空数组与字符串
#define CheckStr(A) ([A isKindOfClass:[NSNull class]] || !A || [A length]<1)
#define CheckArray(A) ([A isKindOfClass:[NSNull class]] || A == nil || A.count == 0)

#define AutoTextSize(text, textFont)  [text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: textFont} context:nil].size

#endif /* LSSRulerConst_h */
