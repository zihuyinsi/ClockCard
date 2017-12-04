//
//  ClockCalendarView.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCalendarView.h"
#import "ClockCalendarHearder.h"
#import "ClockCalendarWeekView.h"
#import "ClockCalendarCollectionViewCell.h"
#import "CalendarDayModel.h"
#import "CalendarMonthModel.h"
#import "NSDate+Calendar.h"

@interface ClockCalendarView()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) ClockCalendarHearder *calendarHearder;    ///< 头部
@property (nonatomic, strong) ClockCalendarWeekView *weekView;          ///< 周
@property (nonatomic, strong) UICollectionView *collectionView;         ///< 日历

@property (nonatomic, strong) NSMutableArray *monthDayArr;      ///< 当月模型集合
@property (nonatomic, strong) NSDate *currentMonthDate;         ///< 当月的日期
@property (nonatomic, strong) CalendarDayModel *selectModel;    ///< 选中的

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;//左滑手势
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;//右滑手势

@property (nonatomic, strong) UILabel *toworkMsgLabel;      ///< xxx
@property (nonatomic, strong) UILabel *offworkMsgLabel;

@end

@implementation ClockCalendarView

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        self.currentMonthDate = [NSDate date];
        CalendarMonthModel *monthModel = [[CalendarMonthModel alloc] initWithDate: self.currentMonthDate];
        [self showRemarksWithDate: [NSString stringWithFormat: @"%ld", (long)monthModel.year]
                         monthStr: [NSString stringWithFormat: @"%ld", (long)monthModel.month]
                           dayStr: [NSString stringWithFormat: @"%ld", (long)monthModel.day]];
        
        [self initializationClockCalenderView];
    }
    
    return self;
}

/*** 初始化 */
- (void) initializationClockCalenderView
{
    //
    [self addSubview: self.calendarHearder];
    WeakObj(self);
    self.calendarHearder.leftButtonClickBlock = ^{
        [weakself rightSlide];
    };
    self.calendarHearder.rightButtonClickBlock = ^{
        [weakself leftSlide];
    };
    
    //
    [self addSubview: self.weekView];
    
    //
    [self addSubview: self.collectionView];
    
    //滑动手势
    self.leftSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(leftSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:self.rightSwipe];
    
    //
    [self addSubview: self.toworkMsgLabel];
    [self addSubview: self.offworkMsgLabel];
}

#pragma makr - data
- (void) requestData
{
    [self.monthDayArr removeAllObjects];
    
    NSDate *previousMonthDate = [self.currentMonthDate previousMonthDate];
    CalendarMonthModel *monthModel = [[CalendarMonthModel alloc] initWithDate: self.currentMonthDate];
    CalendarMonthModel *lastMonthModel = [[CalendarMonthModel alloc] initWithDate: previousMonthDate];
    
    //设置标题年月
    self.calendarHearder.dateStr = [NSString stringWithFormat: @"%ld年%ld月", monthModel.year, monthModel.month];
 
    NSInteger firstWeekday = monthModel.firstWeekday;
    NSInteger totalDays = monthModel.totalDays;
    for (int i = 0; i < 42; i ++)
    {
        CalendarDayModel *model = [[CalendarDayModel alloc] init];
        
        //配置外设
        [self configDayModel: model];
        
        model.firstWeekday = firstWeekday;
        model.totalDays = totalDays;
        model.month = monthModel.month;
        model.year = monthModel.year;
        
        //上个月日期
        if (i < firstWeekday)
        {
            model.day = lastMonthModel.totalDays - (firstWeekday - i) + 1;
            model.isLastMonth = YES;
        }
        //当前月日期
        if (i >= firstWeekday && i < (firstWeekday + totalDays))
        {
            model.day = i - firstWeekday + 1;
            model.isCurrentMonth = YES;
            
            //今天
            if ((monthModel.month == [[NSDate date] dateMonth]) &&
                (monthModel.year == [[NSDate date] dateYear]))
            {
                if (i == [[NSDate date] dateDay] + firstWeekday - 1)
                {
                    model.isToday = YES;
                }
            }
        }
        //下月日期
        if (i >= (firstWeekday + monthModel.totalDays))
        {
            model.day = i - firstWeekday - monthModel.totalDays + 1;
            model.isNextMonth = YES;
        }
        
        [self.monthDayArr addObject: model];
    }
    
    [self.monthDayArr enumerateObjectsUsingBlock:^(CalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.year == self.selectModel.year &&
            obj.month == self.selectModel.month &&
            obj.day == self.selectModel.day)
        {
            obj.isSelected = YES;
        }
    }];
    
    [self.collectionView reloadData];
}

- (void) configDayModel: (CalendarDayModel *)model
{
    //配置外面属性
    model.currentMonthTitleColor = self.currentMonthTitleColor;
    model.lastMonthTitleColor = self.lastMonthTitleColor;
    model.nextMonthTitleColor = self.nextMonthTitleColor;
    model.selectBackColor = self.selectBackColor;
    model.todayTitleColor = self.todayTitleColor;
    model.isShowLastAndNextDate = self.isShowLastAndNextDate;
}

#pragma mark - UICollectionViewDelegate / UICollectionViewDataSource
- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.monthDayArr count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"ClockCalendarCell";
    ClockCalendarCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier: cellIdentifier
                                              forIndexPath: indexPath];
    if (cell == nil)
    {
        cell = [[ClockCalendarCollectionViewCell alloc] init];
    }
    cell.backgroundColor = [UIColor whiteColor];

    
    cell.dayModel = self.monthDayArr[indexPath.row];
    
    return cell;
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    CalendarDayModel *model = self.monthDayArr[indexPath.row];
    model.isSelected = YES;
    
    self.selectModel = model;
    [self.monthDayArr enumerateObjectsUsingBlock:^(CalendarDayModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != model)
        {
            obj.isSelected = NO;
        }
    }];
    
    if (self.selectedBlock)
    {
        self.selectedBlock(model.year, model.month, model.day);
    }
    
    [collectionView reloadData];
    [self showRemarksWithDate: [NSString stringWithFormat: @"%ld", (long)model.year]
                     monthStr: [NSString stringWithFormat: @"%ld", (long)model.month]
                       dayStr: [NSString stringWithFormat: @"%ld", (long)model.day]];
}

#pragma mark - 滑动手势
-(void)leftSwipe: (UISwipeGestureRecognizer *)swipe
{
    [self leftSlide];
}

-(void)rightSwipe: (UISwipeGestureRecognizer *)swipe
{
    [self rightSlide];
}

#pragma mark - left / right
- (void) leftSlide
{
    self.currentMonthDate = [self.currentMonthDate nextMonthDate];
    [self performAnimations: kCATransitionFromRight];
    
    [self requestData];
    [self showRemarksWithDate: @"" monthStr: @"" dayStr: @""];
}

- (void) rightSlide
{
    self.currentMonthDate = [self.currentMonthDate previousMonthDate];
    [self performAnimations: kCATransitionFromLeft];
    
    [self requestData];
    [self showRemarksWithDate: @"" monthStr: @"" dayStr: @""];
}

#pragma mark--动画处理--
- (void)performAnimations:(NSString *)transition
{
    CATransition *catransition = [CATransition animation];
    catransition.duration = 0.5;
    [catransition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    catransition.type = kCATransitionPush; //choose your animation
    catransition.subtype = transition;
    [self.collectionView.layer addAnimation:catransition forKey:nil];
}

#pragma mark - 展示备注信息
- (void) showRemarksWithDate: (NSString *)yearStr
                    monthStr: (NSString *)monthStr
                      dayStr: (NSString *)dayStr
{
    if ([PublicFactory stringIsNull: yearStr] ||
        [PublicFactory stringIsNull: monthStr] ||
        [PublicFactory stringIsNull: dayStr])
    {
        [self.toworkMsgLabel setText: @""];
        [self.offworkMsgLabel setText: @""];
    }
    else
    {
        NSString *resultStr = [[ClockCardDB sharedClockCardDB] selectTo_Off_work: yearStr
                                                                           month: monthStr
                                                                             day: dayStr
                                                                       isRemarks: YES];
        NSArray *timeArr = [resultStr componentsSeparatedByString: @"&&"];
        if ([timeArr count] > 1)
        {
            //上班时间
            if ([PublicFactory stringIsNull: timeArr[0]] ||
                [timeArr[0] isEqualToString: @"\n"])
            {
                [self.toworkMsgLabel setText: @""];
            }
            else
            {
                NSString *toworkStr = [NSString stringWithFormat: @"上班打卡：%@", timeArr[0]];
                NSArray *toworkArr = [toworkStr componentsSeparatedByString: @"\n"];
                NSString *timeStr = toworkArr[0];
                NSString *remarksStr = toworkArr[1];
                NSMutableAttributedString *toworkAtt = [[NSMutableAttributedString alloc] initWithString: toworkStr];
                [toworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 14.f]
                                  range: [toworkStr rangeOfString: timeStr]];
                [toworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(40, 191, 150)
                                  range: [toworkStr rangeOfString: timeStr]];
                [toworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 13.f]
                                  range: [toworkStr rangeOfString: remarksStr]];
                [toworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(114, 114, 114)
                                  range: [toworkStr rangeOfString: remarksStr]];
                [self.toworkMsgLabel setAttributedText: toworkAtt];
            }
            
            //下班时间
            if ([PublicFactory stringIsNull: timeArr[1]] ||
                [timeArr[1] isEqualToString: @"\n"])
            {
                [self.offworkMsgLabel setText: @""];
            }
            else
            {
                NSString *offworkStr = [NSString stringWithFormat: @"上班打卡：%@", timeArr[1]];
                NSArray *offworkArr = [offworkStr componentsSeparatedByString: @"\n"];
                NSString *timeStr = offworkArr[0];
                NSString *remarksStr = offworkArr[1];
                NSMutableAttributedString *offworkAtt = [[NSMutableAttributedString alloc] initWithString: offworkStr];
                [offworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 14.f]
                                  range: [offworkStr rangeOfString: timeStr]];
                [offworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(255, 60, 30)
                                  range: [offworkStr rangeOfString: timeStr]];
                [offworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 13.f]
                                  range: [offworkStr rangeOfString: remarksStr]];
                [offworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(114, 114, 114)
                                  range: [offworkStr rangeOfString: remarksStr]];
                [self.offworkMsgLabel setAttributedText: offworkAtt];
            }
        }
        else if ([timeArr count] > 0)
        {
            if ([PublicFactory stringIsNull: timeArr[0]] ||
                [timeArr[0] isEqualToString: @"\n"])
            {
                [self.toworkMsgLabel setText: @""];
                [self.offworkMsgLabel setText: @""];
            }
            else
            {
                NSString *toworkStr = [NSString stringWithFormat: @"上班打卡：%@", timeArr[0]];
                NSArray *toworkArr = [toworkStr componentsSeparatedByString: @"\n"];
                NSString *timeStr = toworkArr[0];
                NSString *remarksStr = toworkArr[1];
                NSMutableAttributedString *toworkAtt = [[NSMutableAttributedString alloc] initWithString: toworkStr];
                [toworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 14.f]
                                  range: [toworkStr rangeOfString: timeStr]];
                [toworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(40, 191, 150)
                                  range: [toworkStr rangeOfString: timeStr]];
                [toworkAtt addAttribute: NSFontAttributeName
                                  value: [UIFont systemFontOfSize: 13.f]
                                  range: [toworkStr rangeOfString: remarksStr]];
                [toworkAtt addAttribute: NSForegroundColorAttributeName
                                  value: RGBColor(114, 114, 114)
                                  range: [toworkStr rangeOfString: remarksStr]];
                [self.toworkMsgLabel setAttributedText: toworkAtt];
                [self.offworkMsgLabel setText: @""];
            }
        }
    }
}

#pragma mark - setter / getter
/*** 年月 */
- (ClockCalendarHearder *)calendarHearder
{
    if (_calendarHearder == nil)
    {
        _calendarHearder = [[ClockCalendarHearder alloc] init];
        [_calendarHearder setBackgroundColor: [UIColor whiteColor]];
        [_calendarHearder setFrame: CGRectMake(0.f, 10.f, SysWidth, 45.f)];
    }
    
    return _calendarHearder;
}

/*** 星期 */
- (ClockCalendarWeekView *)weekView
{
    if (_weekView == nil)
    {
        _weekView = [[ClockCalendarWeekView alloc] init];
        [_weekView setFrame: CGRectMake(15.f, CGRectGetMaxY(self.calendarHearder.frame)+5.f, SysWidth-30.f, 30.f)];
        [_weekView setBackgroundColor: [UIColor whiteColor]];
        _weekView.weekArr = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    }
    
    return _weekView;
}

/*** 展示日期 */
- (UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        UICollectionViewFlowLayout *flow =[[UICollectionViewFlowLayout alloc] init];
        flow.minimumInteritemSpacing = 0;
        flow.minimumLineSpacing = 0;
        flow.sectionInset =UIEdgeInsetsMake( 0, 0, 0, 0);
        flow.itemSize = CGSizeMake((SysWidth-30)/7, 50);
        
        _collectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.weekView.frame), (SysWidth-30), 6 * 50) collectionViewLayout: flow];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollsToTop = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        UINib *nib = [UINib nibWithNibName:@"ClockCalendarCollectionViewCell" bundle:nil];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ClockCalendarCell"];
    }
    
    return _collectionView;
}

/*** 上班备注信息 */
- (UILabel *) toworkMsgLabel
{
    if (_toworkMsgLabel == nil)
    {
        _toworkMsgLabel = [[UILabel alloc] init];
        [_toworkMsgLabel setNumberOfLines: 0];
        [_toworkMsgLabel setFrame: CGRectMake(15, CGRectGetMaxX(self.collectionView.frame), (SysWidth-30), 40.f)];
    }
    
    return _toworkMsgLabel;
}

/*** 下班备注信息 */
- (UILabel *) offworkMsgLabel
{
    if (_offworkMsgLabel == nil)
    {
        _offworkMsgLabel = [[UILabel alloc] init];
        [_offworkMsgLabel setNumberOfLines: 0];
        [_offworkMsgLabel setFrame: CGRectMake(15, CGRectGetMaxY(self.toworkMsgLabel.frame), (SysWidth-30), 40.f)];
    }
    
    return _offworkMsgLabel;
}


/*** 当月模型集合 */
- (NSMutableArray *)monthDayArr
{
    if (_monthDayArr == nil)
    {
        _monthDayArr = [NSMutableArray array];
    }
    return _monthDayArr;
}

#pragma mark 外设
/*** 当前月title颜色 */
- (void) setCurrentMonthTitleColor:(UIColor *)currentMonthTitleColor
{
    _currentMonthTitleColor = currentMonthTitleColor;
}

/*** 上月title颜色 */
- (void) setLastMonthTitleColor:(UIColor *)lastMonthTitleColor
{
    _lastMonthTitleColor = lastMonthTitleColor;
}

/*** 下月title颜色 */
- (void) setNextMonthTitleColor:(UIColor *)nextMonthTitleColor
{
    _nextMonthTitleColor = nextMonthTitleColor;
}

/*** 今日title颜色 */
- (void) setTodayTitleColor:(UIColor *)todayTitleColor
{
    _todayTitleColor = todayTitleColor;
}

/*** 选中的背景色 */
- (void) setSelectBackColor:(UIColor *)selectBackColor
{
    _selectBackColor = selectBackColor;
}

/*** 是否禁止手势滚动 */
- (void) setIsCanScroll:(BOOL)isCanScroll
{
    _isCanScroll = isCanScroll;
    
    self.leftSwipe.enabled = self.rightSwipe.enabled = isCanScroll;
}

/*** 是否显示下月、下月按钮 */
- (void) setIsShowLastAndNextBtn:(BOOL)isShowLastAndNextBtn
{
    _isShowLastAndNextBtn = isShowLastAndNextBtn;
    
    self.calendarHearder.isShowLeftAndRightBtn = isShowLastAndNextBtn;
}

/*** 是否显示上月、下月数据 */
- (void) setIsShowLastAndNextDate:(BOOL)isShowLastAndNextDate
{
    _isShowLastAndNextDate = isShowLastAndNextDate;
}

#pragma mark - dealRequestDate
- (void) dealData
{
    [self requestData];
}

@end
