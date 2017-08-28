//
//  LSSRulerView.m
//  LSSRulerCollection
//
//  Created by lss on 2017/3/3.
//  Copyright © 2017年 liuss. All rights reserved.
//

#import "LSSRulerView.h"
#import "LSSRulerTool.h"

@interface LSSRullerCell : UICollectionViewCell

#pragma mark - 类=============================Cell的定制
@property(nonatomic,strong)UILabel *longLine;
@property(nonatomic,strong)UILabel *shortLine1;
@property(nonatomic,strong)UILabel *shortLine2;
@property(nonatomic,strong)UILabel *shortLine3;
@property(nonatomic,strong)UILabel *shortLine4;
@property(nonatomic,strong)UILabel *titleLable;

/**
 *  default is default is 0xc7c7c7
 */
@property (nonatomic, strong) UIColor *LineColor;
/**
 * 长刻度的长度，default is 24
 */
@property (nonatomic, assign) CGFloat longDistance;
/**
 * //短刻度的长度，default is 12
 */
@property (nonatomic, assign) CGFloat shortDistance;

@property (nonatomic, strong) UIFont *textFont;
//宽度
@property (nonatomic, assign) CGFloat rulerSpace;
-(void)setStyleWithHeight:(CGFloat)height;
@end

@implementation LSSRullerCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor lightGrayColor];
        [self initUI];
    }
    return self;
}

#pragma mark -布局
-(void)initUI{
    if (!_longLine) {
        _longLine = [[UILabel alloc] init];
        [self.contentView addSubview:_longLine];
    }
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLable];
    }
    if (!_shortLine1) {
        _shortLine1 = [[UILabel alloc] init];
        [self.contentView addSubview:_shortLine1];
    }
    if (!_shortLine2) {
        _shortLine2 = [[UILabel alloc] init];
        [self.contentView addSubview:_shortLine2];
    }
    if (!_shortLine3) {
        _shortLine3 = [[UILabel alloc] init];
        [self.contentView addSubview:_shortLine3];
    }
    if (!_shortLine4) {
        _shortLine4 = [[UILabel alloc] init];
        [self.contentView addSubview:_shortLine4];
    }
}
#pragma mark- 设置cell的样式
-(void)setStyleWithHeight:(CGFloat)height{
    self.longLine.frame =CGRectMake(0, (height-self.longDistance)/2.0, 1, self.longDistance);
    //根据字体大小设置显示的字体宽度
    CGSize titleSize = AutoTextSize(@"88:88", self.textFont);
    self.titleLable.frame = CGRectMake(CGRectGetMaxX(self.longLine.frame), height-TheLenthOfTen, titleSize.width, TheLenthOfTen);
    self.shortLine1.frame = CGRectMake(CGRectGetMaxX(self.longLine.frame)+(self.rulerSpace-1),(height-self.shortDistance)/2.0,1, self.shortDistance);
    self.shortLine2.frame = CGRectMake(CGRectGetMaxX(self.shortLine1.frame)+self.rulerSpace-1,(height-self.shortDistance)/2.0,1, self.shortDistance);
    self.shortLine3.frame = CGRectMake(CGRectGetMaxX(self.shortLine2.frame)+self.rulerSpace-1,(height-self.shortDistance)/2.0,1, self.shortDistance);
    self.shortLine4.frame = CGRectMake(CGRectGetMaxX(self.shortLine3.frame)+self.rulerSpace-1,(height-self.shortDistance)/2.0,1, self.shortDistance);
    self.longLine.backgroundColor  = self.LineColor;
    self.titleLable.textColor = self.LineColor;
    self.titleLable.font = self.textFont;
    self.shortLine1.backgroundColor = self.LineColor;
    self.shortLine2.backgroundColor = self.LineColor;
    self.shortLine3.backgroundColor = self.LineColor;
    self.shortLine4.backgroundColor = self.LineColor;
}

@end


#pragma mark - 类=============================尺子指示的设置
@interface LSSRulerMarkView : UIView;
@property (nonatomic, strong) UIColor *markColor;//尺子指示颜色
@property (nonatomic, strong) CAShapeLayer *markLayer;//CAShapeLayer画图
@end

@implementation LSSRulerMarkView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}
#pragma mark -尺子指示的setupUI
- (void)setupUI {
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height=  CGRectGetHeight(self.bounds);
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = self.bounds;
    layer.lineWidth = width;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(width, 0)];
    [path addLineToPoint:CGPointMake(width, height)];
    [path addLineToPoint:CGPointMake(0, height)];
    [path closePath];
    layer.path = path.CGPath;
    self.markLayer = layer;
    [self.layer addSublayer:layer];
}
- (void)setMarkColor:(UIColor *)markColor {
    _markColor = markColor;
    self.markLayer.fillColor = markColor.CGColor;
    self.markLayer.borderColor = markColor.CGColor;
}
@end

#pragma mark - 类=============================刻度尺线的设置
@interface LSSRulerView()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGFloat centerPointX;
    BOOL isFist;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) LSSRulerMarkView *markView;
@end

@implementation LSSRulerView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataArr =[[NSMutableArray alloc] init];
        isFist =YES;
        [self setupDefault];
        
    }
    return self;
}
#pragma mark - 数据的默认值
- (void)setupDefault {
    self.vidioBackColor = [UIColor orangeColor];
    self.rulerBackgroundColor = [UIColor blackColor];
    self.alpha = 0.3;
    self.rulerLineColor = [UIColor whiteColor];
    self.rulerFont = [UIFont boldSystemFontOfSize:12];
    self.rulerSpacing =(float)(self.bounds.size.width/6.0)/5.0;
    self.minValue = 0;
    self.longLineDistance = 30;
    self.shortLineDistance = 16;
    self.itemCGSize = CGSizeMake(self.rulerSpacing*5, 60);
    self.minValue = 0;
    self.rulerTime = 12; //每一格代表多少秒  默认12s
    self.rulerStartTime = [LSSRulerTool HowManyHoursAgoWith:8];//从最近8小时开始
    self.rulerEndTime = [LSSRulerTool HowManyHoursAgoWith:0];
    self.currentValue = 0;
    self.backgroundColor = self.rulerBackgroundColor;
    self.maxValue = [self calculateTheScaleValue];//最大格数  默认600/5格      ------默认为最近8小时
}
#pragma mark-计算开始时间与结束时间之间的差值 需要多少item
-(NSInteger)calculateTheScaleValue{
    NSInteger Value;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:self.rulerStartTime];
    NSDate *date2 = [dateFormatter dateFromString:self.rulerEndTime];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    NSTimeInterval interval = (int)time;
    Value = (int)interval/self.rulerTime/5;
    NSInteger ValueX= (int)interval%(self.rulerTime*5);
    if (ValueX !=0) {
        Value = Value+1;
    }
    return Value;
}
#pragma mark-布局的设置
-(void)addTheTime{
    //计算半个屏幕有多少秒
    NSTimeInterval interval = self.rulerTime*5*3;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"rulerStartTime"]];
    NSDate * lastYear = [date1 dateByAddingTimeInterval:-interval];
    self.rulerStartTime = [LSSRulerTool getTimeStrByDate:lastYear];
    
    NSDate *date2 = [dateFormatter dateFromString:[[NSUserDefaults standardUserDefaults] objectForKey:@"rulerEndTime"]];
    NSDate * lastYearX = [date2 dateByAddingTimeInterval:interval];
    self.rulerEndTime = [LSSRulerTool getTimeStrByDate:lastYearX];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.rulerStartTime forKey:TheRulerStartTimeValue];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(void)reloadData{
    [_collectionView removeFromSuperview];
    [_markView removeFromSuperview];
#pragma mark-在现有的时间基础上加一点时间
    if (isFist) {
        [[NSUserDefaults standardUserDefaults] setObject:self.rulerStartTime forKey:@"rulerStartTime"];
        [[NSUserDefaults standardUserDefaults] setObject:self.rulerEndTime forKey:@"rulerEndTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    [self addTheTime];
    self.maxValue = [self calculateTheScaleValue];
#pragma mark - 添加Collection
    //1.创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置单元格的尺寸
    flowLayout.itemSize = self.itemCGSize;
    //设置头视图高度
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    //flowlaout的属性，横向滑动
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //2.接下来就在创建collectionView的时候初始化，就很方便了（能直接带上layout）
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    _collectionView.tag = 200;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = self.rulerBackgroundColor;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = YES;
    CGFloat totalWidth = self.itemCGSize.width * (self.maxValue - self.minValue);
    _collectionView.contentSize = CGSizeMake(totalWidth, 0);
    //添加到主页面上去
    [self addSubview:_collectionView];
    //3.collectionCell的注册
    [_collectionView registerClass:[LSSRullerCell class] forCellWithReuseIdentifier:@"cellId"];
    //collection头视图的注册   奇葩的地方来了，头视图也得注册
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellId"];
#pragma mark -添加尺子标示
    self.markView = [[LSSRulerMarkView alloc] initWithFrame:CGRectMake((self.bounds.size.width-1) / 2, 0, 1, self.bounds.size.height)];
    self.markView.translatesAutoresizingMaskIntoConstraints = NO;
    self.markView.markColor = self.rulerLineColor;
    self.markView.backgroundColor = self.rulerLineColor;
    [self addSubview:self.markView];
    centerPointX =_collectionView.bounds.size.width/ 2;
#pragma mark -添加视频片段
    [self loadDataWith:_dataArr];
#pragma mark -添加捏合手势
    // 创建UIPinchGestureRecognizer手势处理器，该手势处理器激发scaleImage:方法
    UIPinchGestureRecognizer* gesture = [[UIPinchGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(scaleView:)];
    // 为imageView添加手势处理器
    [_collectionView addGestureRecognizer:gesture];
    if (isFist) {
        [self updateCurrentValue:0.0];
    }
    isFist = NO;
    
}
#pragma mark - 手势捏合放大缩小
- (void) scaleView:(UIPinchGestureRecognizer*)gesture{
    CGFloat scale = gesture.scale;
    NSString *timeStr;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [[NSUserDefaults standardUserDefaults] setObject:[self timeValue] forKey:@"startTimeS"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (gesture.state == UIGestureRecognizerStateEnded){
        if (scale>1) {
#pragma mark -放大  先调用reloadData 再设置指示标跳到哪里
            self.rulerTime = rulerSmallSecond;
            [self reloadData];
            timeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"startTimeS"];
            self.currentValue = [self sendTheTime:timeStr];
            [self updateCurrentValue:self.currentValue];
        }
        if (scale<=1) {
#pragma mark -缩小 先调用reloadData 再设置指示标跳到哪里
            self.rulerTime = rulerBigSecond;
            [self reloadData];
            timeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"startTimeS"];
            self.currentValue = [self sendTheTime:timeStr];
            [self updateCurrentValue:self.currentValue];
            
        }
    }
}
#pragma mark - 传入时间返回current值
-(CGFloat)sendTheTime:(NSString *)time{
    CGFloat current;
    NSDate *currentDate = [LSSRulerTool getDateByTimeStr:time];
    NSString *old1 =[[NSUserDefaults standardUserDefaults]objectForKey:TheRulerStartTimeValue];
    NSDate *olddate = [LSSRulerTool getDateByTimeStr:old1];
    NSTimeInterval start2= [currentDate timeIntervalSince1970]*1;
    NSTimeInterval old2 = [olddate timeIntervalSince1970]*1;
    //计算每一秒的宽度
    float spaceX = (float)self.rulerSpacing/self.rulerTime;
    //计算起始值X
    NSTimeInterval valueX = start2 - old2;
    int secondX = (int)valueX;//秒 //与过去时间对比
    float withX  = spaceX*secondX;
    CGFloat offsetX = withX;
    current = offsetX;
    return current;
}
#pragma mark -根据currentValue值改变位置
- (void)updateCurrentValue:(CGFloat)value {
    self.currentValue = value;
    CGFloat offsetX = self.currentValue-centerPointX;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
}
#pragma mark -传入某个视频时间 查看是否存在视频
-(BOOL)sendTheVideoTime:(NSString *)time{
    BOOL isExist;
    if (!CheckArray(_dataArr)) {
        for (int i = 0; i<_dataArr.count; i++) {
            if (!isExist) {
                UIView *view = [[UIView alloc] init];
                view.userInteractionEnabled = YES;
                //根据时间设置开始X
                LSSRulerTool *item = _dataArr[i];
                NSString *start= item.startTime;
                NSString *end= item.endTime;
                NSDate *startDate = [LSSRulerTool getDateByTimeStr:start];
                NSDate *expireDate = [LSSRulerTool getDateByTimeStr:end];
                NSDate *currentDate = [LSSRulerTool getDateByTimeStr:time];
                NSString *old1 =[[NSUserDefaults standardUserDefaults]objectForKey:TheRulerStartTimeValue];
                NSDate *olddate = [LSSRulerTool getDateByTimeStr:old1];
                NSTimeInterval start2= [currentDate timeIntervalSince1970]*1;
                NSTimeInterval old2 = [olddate timeIntervalSince1970]*1;
                //计算每一秒的宽度
                float spaceX = (float)self.rulerSpacing/self.rulerTime;
                //计算起始值X
                NSTimeInterval valueX = start2 - old2;
                int secondX = (int)valueX;//秒 //与过去时间对比
                float withX  = spaceX*secondX;
                CGFloat offsetX = withX ;
                [self.collectionView setContentOffset:CGPointMake(offsetX-centerPointX, 0) animated:YES];
                self.currentValue = offsetX;
                if ([currentDate compare:startDate] == NSOrderedDescending && [currentDate compare:expireDate] == NSOrderedAscending) {
                    isExist = YES;
                }else{
                    isExist = NO;
                }
                
            }
            
        }
    }
    return isExist;
}
#pragma mark -根据传进来的数组添加view显示视频有无（颜色区分）
-(void)loadDataWith:(NSArray *)dataArr{
    
    for (id obj in _collectionView.subviews)  {
        if ([obj isKindOfClass:[UIImageView class]]) {
            [obj removeFromSuperview];
        }
    }
    if (!CheckArray(dataArr)) {
        for (int i = 0; i<dataArr.count; i++) {
            //根据时间设置开始X
            LSSRulerTool *item = dataArr[i];
            NSString *start1= item.startTime;
            NSString *end1= item.endTime;
            NSString *old1 =[[NSUserDefaults standardUserDefaults]objectForKey:TheRulerStartTimeValue];
            NSDate *startdate = [LSSRulerTool getDateByTimeStr:start1];
            NSDate *enddate = [LSSRulerTool getDateByTimeStr:end1];
            NSDate *olddate = [LSSRulerTool getDateByTimeStr:old1];
            
            NSTimeInterval start = [startdate timeIntervalSince1970]*1;
            NSTimeInterval end = [enddate timeIntervalSince1970]*1;
            NSTimeInterval old = [olddate timeIntervalSince1970]*1;
            //计算每一秒的宽度
            float spaceX = (float)self.rulerSpacing/self.rulerTime;
            //计算起始值X
            NSTimeInterval valueX = start - old;
            int secondX = (int)valueX;//秒 //与过去时间对比
            float withX  = spaceX*secondX;
            //计算显示宽度
            NSTimeInterval valueW = end - start;
            int secondW = (int)valueW;//秒 //与过去时间对比
            float widTh  = spaceX*secondW;
            UIImageView *view = [[UIImageView alloc] init];
            view.userInteractionEnabled = YES;
            view.frame = CGRectMake(withX, 0, widTh, self.bounds.size.height);
            view.backgroundColor = self.vidioBackColor;
            view.alpha = 0.5;
            view.userInteractionEnabled = YES;
            [_collectionView addSubview:view];
        }
    }
}
#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.maxValue;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row<=2 ||indexPath.item>=self.maxValue-3 ) {
             LSSRullerCell *cell = (LSSRullerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        cell.backgroundColor = self.rulerBackgroundColor;
        cell.LineColor = self.rulerBackgroundColor;
        cell.longDistance = 0;
        cell.shortDistance = 0;
        cell.textFont = self.rulerFont;
        cell.rulerSpace = 0;
        [cell setStyleWithHeight:self.bounds.size.height];

        return cell;
    }
        LSSRullerCell *cell = (LSSRullerCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
        //Cell的定制
        cell.backgroundColor = self.rulerBackgroundColor;
        cell.LineColor = self.rulerLineColor;
        cell.longDistance = self.longLineDistance;
        cell.shortDistance = self.shortLineDistance;
        cell.textFont = self.rulerFont;
        cell.rulerSpace = self.rulerSpacing;
        [cell setStyleWithHeight:self.bounds.size.height];
        //设置时间显示
        cell.titleLable.text = [self HowManySecondsWith:self.rulerStartTime WithEndTime:self.rulerEndTime WithI:indexPath.item];
    
    if (indexPath.item == self.maxValue-4) {
        //解决最后一刻度线显示问题
        UILabel *lastLong = [[UILabel alloc] init];
        [cell.contentView addSubview:lastLong];
        lastLong.frame = CGRectMake(CGRectGetMaxX(cell.shortLine4.frame)+self.rulerSpacing-2,(self.bounds.size.height-self.longLineDistance)/2.0,1, self.longLineDistance);
        lastLong.backgroundColor = self.rulerLineColor;
        //解决最后一刻度值显示问题
        CGSize titleSize = AutoTextSize(@"88:88", self.rulerFont);
        UILabel *lastLable = [[UILabel alloc] init];
        [cell.contentView addSubview:lastLable];
        lastLable.frame = CGRectMake(CGRectGetMaxX(lastLong.frame), self.bounds.size.height-TheLenthOfTen, titleSize.width, TheLenthOfTen);
        lastLable.textColor = self.rulerLineColor;
        lastLable.font = self.rulerFont;
        lastLable.text = [self HowManySecondsWith:self.rulerStartTime WithEndTime:self.rulerEndTime WithI:indexPath.item+1];
    }
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.item == self.maxValue-4) {
        
        CGSize titleSize = AutoTextSize(@"88:88", self.rulerFont);
        
        return CGSizeMake(self.rulerSpacing*5+titleSize.width, 60);
    }
    return self.itemCGSize;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX+centerPointX) ;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_rulerViewCurrentValue:)]) {
        [self.delegate zyy_rulerViewCurrentValue:[self timeValue]];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_rulerViewCurrentValue:rulerView:)]) {
        [self.delegate zyy_rulerViewCurrentValue:[self timeValue] rulerView:self];
    }

    if (self.valueChangeCallback) {
        self.valueChangeCallback(self.currentValue);
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    //将要结束拖动
    CGFloat offsetX = scrollView.contentOffset.x;
    self.currentValue = (offsetX +centerPointX);
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_StopRulerViewCurrentValue:)]) {
        [self.delegate zyy_StopRulerViewCurrentValue:[self timeValue]];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 已经结束拖动
    CGFloat offsetX = scrollView.contentOffset.x;
     self.currentValue = (offsetX +centerPointX) ;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(zyy_StopRulerViewCurrentValue:)]) {
        [self.delegate zyy_StopRulerViewCurrentValue:[self timeValue]];
    }
    
    if (self.valueChangeCallback) {
        self.valueChangeCallback(self.currentValue);
    }
}

#pragma mark - 计算出返回的时间字符串值
-(NSString *)timeValue{
    NSTimeInterval interval = self.currentValue*(float)self.rulerTime/self.rulerSpacing;
    NSString *strs =[[NSUserDefaults standardUserDefaults]objectForKey:TheRulerStartTimeValue];
    NSDate *old = [LSSRulerTool getDateByTimeStr:strs];
    NSDate *detea = [NSDate dateWithTimeInterval:interval sinceDate:old];
    NSString *timeValue = [LSSRulerTool getTimeStrByDate:detea];
    return timeValue;
}
#pragma mark- 计算两个时间之间隔了多少秒 递增或者递减
-(NSString *)HowManySecondsWith:(NSString *)starTime WithEndTime:(NSString *)endTime WithI:(NSInteger)i{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    //然后创建日期对象
    NSDate *date1 = [dateFormatter dateFromString:starTime];
    NSDate *date2 = [dateFormatter dateFromString:endTime];
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    NSTimeInterval interval = (int)time-i*(self.rulerTime*5);
    NSDate * lastYear = [date2 dateByAddingTimeInterval:-interval];
    NSString *timeStr = [LSSRulerTool getTimeStrByDateDay:lastYear];
    return timeStr;
}


@end
