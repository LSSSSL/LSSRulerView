# LSSRulerView
[![Ruller](https://img.shields.io/badge/Ruller-1.0.0-ff69b4.svg)](https://github.com/LSSSSL/LSSRulerView)
[![Author](https://img.shields.io/badge/author-LSSSSL-yellowgreen.svg)](https://github.com/LSSSSL)

## 功能描述
1. UICollectionView定多样式刻度尺、适用视频播放进度尺、度量尺
2. 分段设置区域位置、区域色彩、放大缩小刻度值
3. 自动按属性刻度滚动尺标、定位具体时间
4. 若传入视频数据，可根据视频始末时间判断该视频是否存在于某个时间

![image](https://github.com/LSSSSL/LSSRulerView/blob/master/%20Image/img.gif)

## 环境配置
* Xcode 6 or higher
* iOS 7.0 or higher
* ARC

## 文件介绍
1. LSSRulerView   主类 主要的刻度尺逻辑功能的实现
2. LSSRulerTool 改类包含 视频数据数组模型定义(视频播放用)、Date Time 函数的集合
3. LSSRulerConst.h 基本使用宏的定义

### 视频数据模型
```
@property(nonatomic,copy)NSString *startTime;//视频开始时间
@property(nonatomic,copy)NSString *endTime;//视频结束时间
@property(nonatomic,copy)NSString *NvrUrl;//视频地址
```
## 调用使用
1. 所有你需要做的就是把Class文件导入到您的项目,并添加#import "LSSRulerView.h"、#import "LSSRulerTool.h"的类将使用它。
2. 实例化 LSSRulerView 类、 遵循代理、设置属性、根据个人需求实现代理方法。
```
    //初始化-方式
    DefaultRulerView = [[LSSRulerView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 60)];
    DefaultRulerView.delegate =self;
    DefaultRulerView.tag  = 1;
    [self.view addSubview:DefaultRulerView];
    [DefaultRulerView reloadData];
    
    //属性设置
    CoustomRulerView.rulerTime = 720;
    CoustomRulerView.rulerLineColor = [UIColor blackColor];
    CoustomRulerView.rulerBackgroundColor = [UIColor whiteColor];
    CoustomRulerView.rulerStartTime =@"2017/3/1 00:00:00";
    CoustomRulerView.rulerEndTime = @"2017/3/05 00:00:00";
    CoustomRulerView.markViewColor =[UIColor redColor];
    [CoustomRulerView reloadData];
    [CoustomRulerView GoTheTime:@"2017/3/01 12:30:25"];
```
### 代理\方法解释
####  代理触及方法
```
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
 *  当尺子滑动停止时触及的方法
 *
 *  @param value 尺子当前指向的值
 */
- (void)zyy_StopRulerViewCurrentValue:(NSString *)value;
```
#### 方法调用
```
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
```
##  注意
  ####  有属性改变一定要调用此方法  - (void)reloadData;
 ```
  如 :[View reloadData]
 ```
  #### 2. 自动滚动刻度尺克自行加入 时间控制器 NSTimer 如：
  ```
   timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(printString)
                                           userInfo:nil
                                            repeats:true];
    
    -(void)printString{
    i++;//测试随便给的值
    if (i<10) {
        NSString *timeS = [NSString stringWithFormat:@"2017/03/02 12:50:3%d",i];
        BOOL is = [View sendTheVideoTime:timeS]; 
        if (is) {
            NSLog(@"时间存在");
        }else{
            NSLog(@"时间不存在");
        }
    }
}
  ```
