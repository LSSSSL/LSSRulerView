//
//  ViewController.m
//  LSSRulerCollection
//
//  Created by lss on 2017/3/3.
//  Copyright © 2017年 liuss. All rights reserved.
//

#import "ViewController.h"
#import "LSSRulerView.h"
#import "LSSRulerTool.h"
@interface ViewController ()<LSSRulerViewDelegate>{
     UILabel *testLabel;
    LSSRulerView *View;
    
    int i;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
    View = [[LSSRulerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 60)];
    View.delegate =self;
    //一般改变这些属性
    View.rulerTime = 12;
    View.rulerStartTime =@"2017/3/01 00:00:00";
    View.rulerEndTime = @"2017/3/08 00:00:00";
    
#pragma mark -测试数据
    //测试数据
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    LSSRulerTool *item1 = [[LSSRulerTool alloc] init];
    item1.startTime = @"2017/3/01  12:50:30";
    item1.endTime = @"2017/3/01 12:55:08";
    LSSRulerTool *item = [[LSSRulerTool alloc] init];
    item.startTime = @"2017/3/01  12:55:30";
    item.endTime = @"2017/3/01 13:00:08";
    LSSRulerTool *item2 = [[LSSRulerTool alloc] init];
    item2.startTime = @"2017/3/07 07:05:30";
    item2.endTime = @"2017/3/07 07:15:08";
    [dataArr addObject:item1];
    [dataArr addObject:item];
    [dataArr addObject:item2];
    NSMutableArray *dataArrS = [NSMutableArray arrayWithArray:dataArr];
    View.dataArr = [NSMutableArray arrayWithArray:dataArrS];
    [self.view addSubview:View];
   
     //有属性改变就要调用此方法
    [View reloadData];
   
//    BOOL is = [View sendTheVideoTime:@"2017/3/03 12:50:30"];
//    if (is) {
//        NSLog(@"时间存在");
//    }else{}
    
    // 时间控制器
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                             target:self
                                           selector:@selector(printString)
                                           userInfo:nil
                                            repeats:true];

    UIButton *buttonClick = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 30, 40)];
    buttonClick.backgroundColor = [UIColor redColor];
    [buttonClick addTarget:self action:@selector(Click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClick];
}
-(void)printString{
    i++;//测试随便给的值
    if (i<10) {
        NSString *timeS = [NSString stringWithFormat:@"2017/03/03 12:50:3%d",i];
        BOOL is = [View sendTheVideoTime:timeS];
        if (is) {
            NSLog(@"时间存在");
        }else{
            NSLog(@"时间不存在");
        }
    }
}

-(void)Click{
   
        //输入某个时间1.跳到该时间  2.返回是否存在视频
        BOOL is = [View sendTheVideoTime:@"2017/3/05 12:30:30"];
        if (is) {
            NSLog(@"时间存在");
        }else{
            NSLog(@"时间不存在");
        }
}
- (void)zyy_rulerViewCurrentValue:(NSString *)value {
    
    NSLog(@"---%@",value);
    testLabel.text =value;
}
-(void)zyy_StopRulerViewCurrentValue:(NSString *)value{
    NSLog(@"stop :%@",value);
}

@end
