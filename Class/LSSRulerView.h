//
//  LSSRulerView.h
//  LSSRulerCollection
//
//  Created by lss on 2017/3/3.
//  Copyright © 2017年 liuss. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LSSRulerView;
@protocol LSSRulerViewDelegate <NSObject>
@optional
/**
 *  代理获取尺子当前指向的值
 *
 *  @param value 尺子当前指向的值
 */
- (void)zyy_rulerViewCurrentValue:(NSString *)value;
/**
 *  代理获取尺子当前指向的值
 *
 *  @param value     尺子当前指向的值
 *  @param rulerView ZYYRulerView
 */
- (void)zyy_rulerViewCurrentValue:(NSString*)value rulerView:(LSSRulerView *)rulerView;
/**
 *  当尺子华东停止时触及的方法
 *
 *  @param value 尺子当前指向的值
 */
- (void)zyy_StopRulerViewCurrentValue:(NSString *)value;
@end


@interface LSSRulerView : UIView

/**
 *  尺子开始时间   格式yyyy／MM／dd HH:mm:ss
 */
@property (copy, nonatomic)NSString *rulerStartTime;
/**
 *  尺子结束时间   格式yyyy／MM／dd HH:mm:ss
 */
@property (copy, nonatomic)NSString *rulerEndTime;
/**
 *  尺子刻度表示的时间值，可变
 */
@property (assign, nonatomic) NSInteger rulerTime;
/**
 *  视频数组时间集合   RulerTool模型
 */
@property(nonatomic,strong)NSMutableArray *dataArr;
/**
 *  default is 0xf9f9f9
 */
@property (nonatomic, strong) UIColor *rulerBackgroundColor;
/**
 *  default is default is 0xc7c7c7
 */
@property (nonatomic, strong) UIColor *rulerLineColor;
/**
 *  视频的颜色
 */
@property (nonatomic, strong) UIColor *vidioBackColor;
/**
 *  尺子上数字的字体
 */
@property (nonatomic, strong) UIFont *rulerFont;
/**
 * 刻度之间的距离，default is 10;涉及到位置的准确性，所以用整型
 */
@property (nonatomic, assign) float rulerSpacing;
/**
 * 长刻度的长度，default is 24
 */
@property (nonatomic, assign) CGFloat longLineDistance;
/**
 * //短刻度的长度，default is 12
 */
@property (nonatomic, assign) CGFloat shortLineDistance;
/**
 * //default is 0
 */
@property (nonatomic, assign) NSInteger minValue;
/**
 * //default is 100
 */
@property (nonatomic, assign) NSInteger maxValue;
/**
 * //指示标记的颜色，default is 0xea5151
 */
@property (nonatomic, strong) UIColor *markViewColor;
/**
 * //当前的刻度指示值
 */
@property (nonatomic, assign) CGFloat currentValue;
/**
 * currentValue变化的回调，showMarkView == NO时无效
 */
@property (nonatomic, copy) void(^valueChangeCallback)(CGFloat currentValue);

/**
 * 设置代理
 */
@property (weak, nonatomic) id <LSSRulerViewDelegate> delegate;
/**
 * //当前的刻度指示值
 */
@property (nonatomic, assign) CGSize itemCGSize;

#pragma mark -方法的调用
/**
 *  更改样式之类的属性后，需要调用reloadData才能生效；有属性改变就要调用此方法
 */
- (void)reloadData;
/**
 *  方法调用传入数据数组
 *
 *  @param dataArr 视频时间数组集合  RulerTool数据模型的集合
 *
 */
-(void)loadDataWith:(NSArray *)dataArr;

/**
 *   传入某个视频时间   1.跳到该时间  2.返回是否存在视频
 *
 *  @param time   某时间     格式   yyyy／MM／dd HH:mm:ss
 
 */
-(BOOL)sendTheVideoTime:(NSString *)time;

/**
 *   传入某个时间   1.跳到该时间
 *
 *  @param time   某时间     格式   yyyy／MM／dd HH:mm:ss
 
 */
-(void)GoTheTime:(NSString *)time;

@end
