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
    UILabel *showLabel1;
    LSSRulerView *DefaultRulerView;
    
    UILabel *showLabel2;
    LSSRulerView *CoustomRulerView;
    
    UILabel *showLabel3;
    LSSRulerView *CoustomVideoRulerView;
    
    int i;
    NSTimer *timer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:225/255.0 green:255/255.0 blue:255/255.0 alpha:1];
   
    //1.默认样式
    [self DefaultUI];
    
    UIButton *buttonClick1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 100, 40)];
    buttonClick1.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    [buttonClick1 setTitle:@"Coustom" forState: UIControlStateNormal];
    [buttonClick1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonClick1 addTarget:self action:@selector(CoustomUI1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClick1];
    
    UIButton *buttonClick2 = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-140, 20, 130, 40)];
    buttonClick2.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    [buttonClick2 setTitle:@"定位时间" forState: UIControlStateNormal];
    [buttonClick2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buttonClick2 addTarget:self action:@selector(CoustomUI2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonClick2];

}

-(void)CoustomUI2
{
    //视频刻度尺- 视频块时间刻度显示
    [self CoustomVideoUI];
}

-(void)CoustomUI1{
    //2.自定义样式
    [self CoustomUI];
}

-(void)printString{
        i++;//测试随便给的值
        if (i<10) {
            NSString *timeS = [NSString stringWithFormat:@"2017/03/02 12:50:3%d",i];
            BOOL is = [CoustomVideoRulerView sendTheVideoTime:timeS];
            if (is) {
                NSLog(@"时间存在");
            }else{
                NSLog(@"时间不存在");
            }
        }
}

#pragma mark- LSSRulerViewDelegate
- (void)zyy_rulerViewCurrentValue:(NSString *)value {
    NSLog(@"---%@",value);
}
-(void)zyy_StopRulerViewCurrentValue:(NSString *)value{
    NSLog(@"stop :%@",value);
}
-(void)zyy_rulerViewCurrentValue:(NSString *)value rulerView:(LSSRulerView *)rulerView
{
    if (rulerView.tag == 1) {
        showLabel1.text =value;
    }else if (rulerView.tag == 2) {
        showLabel2.text =value;
    }else if (rulerView.tag == 3) {
        showLabel3.text =value;
    }
}

#pragma mark-默认刻度尺
-(void)DefaultUI
{
    showLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    showLabel1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel1];
    DefaultRulerView = [[LSSRulerView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 60)];
    DefaultRulerView.delegate =self;
    DefaultRulerView.tag  = 1;
    [self.view addSubview:DefaultRulerView];
    
    [DefaultRulerView reloadData];
}
#pragma mark- 自定制刻度尺
-(void)CoustomUI
{
    showLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    showLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel2];
    CoustomRulerView = [[LSSRulerView alloc] initWithFrame:CGRectMake(0, 260, self.view.frame.size.width, 60)];
    CoustomRulerView.delegate =self;
    CoustomRulerView.tag  = 2;
    CoustomRulerView.rulerTime = 720;
    CoustomRulerView.rulerLineColor = [UIColor blackColor];
    CoustomRulerView.rulerBackgroundColor = [UIColor whiteColor];
    CoustomRulerView.rulerStartTime =@"2017/3/1 00:00:00";
    CoustomRulerView.rulerEndTime = @"2017/3/05 00:00:00";
    CoustomRulerView.markViewColor =[UIColor redColor];

    [self.view addSubview:CoustomRulerView];
    
    [CoustomRulerView reloadData];
    
    [CoustomRulerView GoTheTime:@"2017/3/01 12:30:25"];
}

#pragma mark- 视频刻度尺- 视频块时间刻度显示
-(void)CoustomVideoUI
{
    showLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 310, CGRectGetWidth([UIScreen mainScreen].bounds), 60)];
    showLabel3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel3];
    CoustomVideoRulerView = [[LSSRulerView alloc] initWithFrame:CGRectMake(0, 370, self.view.frame.size.width, 60)];
    CoustomVideoRulerView.delegate =self;
    CoustomVideoRulerView.tag  = 3;
    CoustomVideoRulerView.rulerTime = 24;
    CoustomVideoRulerView.rulerBackgroundColor = [UIColor purpleColor];
    CoustomVideoRulerView.rulerStartTime =@"2017/3/1 00:00:00";
    CoustomVideoRulerView.rulerEndTime = @"2017/3/05 00:00:00";
    CoustomVideoRulerView.markViewColor =[UIColor greenColor];
    CoustomVideoRulerView.vidioBackColor = [UIColor orangeColor];

        //测试数据
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        LSSRulerTool *item1 = [[LSSRulerTool alloc] init];
        item1.startTime = @"2017/3/02  12:50:30";
        item1.endTime = @"2017/3/02 12:55:08";
        LSSRulerTool *item = [[LSSRulerTool alloc] init];
        item.startTime = @"2017/3/03  12:55:30";
        item.endTime = @"2017/3/03 13:00:08";
        LSSRulerTool *item2 = [[LSSRulerTool alloc] init];
        item2.startTime = @"2017/3/04 07:05:30";
        item2.endTime = @"2017/3/04 07:15:08";
        [dataArr addObject:item1];
        [dataArr addObject:item];
        [dataArr addObject:item2];
        NSMutableArray *dataArrS = [NSMutableArray arrayWithArray:dataArr];
    CoustomVideoRulerView.dataArr = [NSMutableArray arrayWithArray:dataArrS];
    
    [self.view addSubview:CoustomVideoRulerView];
    
    [CoustomVideoRulerView reloadData];

    // 时间控制器
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(printString)
                                               userInfo:nil
                                                repeats:true];
    
    UIButton *locationClick = [[UIButton alloc] initWithFrame:CGRectMake((self.view.frame.size.width-130)/2.0, 440, 130, 40)];
    locationClick.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    [locationClick setTitle:@"定位视频时间" forState: UIControlStateNormal];
    [locationClick setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [locationClick addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:locationClick];
}
-(void)click
{
    BOOL is = [CoustomVideoRulerView sendTheVideoTime:@"2017/3/03 12:50:30"];
    if (is) {
        NSLog(@"视频存在");
    }else{}
}
@end
