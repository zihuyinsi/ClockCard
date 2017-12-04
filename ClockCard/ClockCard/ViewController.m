//
//  ViewController.m
//  ClockCard
//
//  Created by lv on 2017/11/16.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ViewController.h"
#import "ClockCalendarViewController.h"
#import <ZJAnimationPopView.h>
#import "CustomAlertView.h"
#import "UIImage+Date.h"

#import "RecordViewController.h"

@interface ViewController ()
{
    UIButton *toWorkBtn;        ///< 上班
    UIButton *offWorkBtn;       ///< 下班
    CustomAlertView *customAlertView;
    
    NSString *workTypeStr;      ///< 上下班
}


@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self handleWorkButtonSize];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    //日历
    UIButton *calendarBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    UIImage *btnImage = [UIImage imageWithDate: [NSDate date]
                                     imageSize: CGSizeMake(30.f, 30.f)];
    [calendarBtn setImage: btnImage forState: UIControlStateNormal];
    [calendarBtn addTarget: self
                    action: @selector(clockCalendar)
          forControlEvents: UIControlEventTouchUpInside];
    [self.view addSubview: calendarBtn];
    [calendarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25.f);
        make.right.mas_equalTo(-10.f);
        make.width.mas_equalTo(35.f);
        make.height.mas_equalTo(35.f);
    }];
    
    //上班
    toWorkBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [toWorkBtn setBackgroundColor: RGBColor(40, 191, 150)];
    [toWorkBtn setTitle: @"上班" forState: UIControlStateNormal];
    [toWorkBtn addTarget: self
                  action: @selector(toWorkBtnClick)
        forControlEvents: UIControlEventTouchUpInside];
    toWorkBtn.layer.masksToBounds = YES;
    toWorkBtn.layer.cornerRadius = 32.5f;
    [self.view addSubview: toWorkBtn];
    [toWorkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(0.f);
        make.top.mas_equalTo(SysWidth/2 - 75.f);
        make.width.mas_equalTo(65.f);
        make.height.mas_equalTo(65.f);
    }];
    //上班长按手势
    UILongPressGestureRecognizer *toWorkLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget: self action:@selector(toWorkButtonLongPress:)];
    toWorkLongPress.minimumPressDuration= 1.25f;//定义按的时间
    [toWorkBtn addGestureRecognizer: toWorkLongPress];
    
    //下班
    offWorkBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [offWorkBtn setBackgroundColor: RGBColor(255, 60, 30)];
    [offWorkBtn setTitle: @"下班" forState: UIControlStateNormal];
    [offWorkBtn.titleLabel setFont: [UIFont systemFontOfSize:15.f]];
    [offWorkBtn addTarget: self
                   action: @selector(offWorkBtnClick)
         forControlEvents: UIControlEventTouchUpInside];
    offWorkBtn.layer.masksToBounds = YES;
    offWorkBtn.layer.cornerRadius = 32.5f;
    [self.view addSubview: offWorkBtn];
    [offWorkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).with.offset(0.f);
        make.top.mas_equalTo(toWorkBtn.mas_bottom).with.offset(20.f);
        make.width.mas_equalTo(65.f);
        make.height.mas_equalTo(65.f);
    }];
    //下班长按手势
    UILongPressGestureRecognizer *offWorkLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget: self action:@selector(offWorkButtonLongPress:)];
    offWorkLongPress.minimumPressDuration= 1.25f;//定义按的时间
    [offWorkBtn addGestureRecognizer: offWorkLongPress];

    //
    customAlertView = [[NSBundle mainBundle] loadNibNamed: @"CustomAlertView" owner: nil options: nil][0];
    customAlertView.layer.masksToBounds = YES;
    customAlertView.layer.cornerRadius = 7.f;
    customAlertView.remarksTextView.layer.masksToBounds = YES;
    customAlertView.remarksTextView.layer.cornerRadius = 3.f;
    customAlertView.remarksTextView.layer.borderWidth = 0.5f;
    customAlertView.remarksTextView.layer.borderColor = RGBColor(240, 240, 240).CGColor;
}

#pragma mark - 获取当前时间，并根据时间来切换按钮大小
- (void) handleWorkButtonSize
{
    [toWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SysHeight/2 - 10.f);
        make.width.mas_equalTo(0.f);
        make.height.mas_equalTo(0.f);
    }];
    [offWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.f);
        make.height.mas_equalTo(0.f);
    }];
    [self.view layoutIfNeeded];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [formatter stringFromDate: date];
    NSLog(@"dateStr = %@", dateStr);
    NSString *timeStr = @"120000";
    if ([dateStr integerValue] > [timeStr integerValue])
    {
        //当前时间大于12点，切换下班为大按钮
        [self offWorkButtonAnimate];
    }
    else
    {
        //当前时间小于12点，切换上班为大按钮
        [self toWorkButtonAnimate];
    }
}

//上班动画
- (void) toWorkButtonAnimate
{
    [UIView animateWithDuration: 1.f
                     animations:^{
                         [toWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.width.mas_equalTo(90.f);
                             make.height.mas_equalTo(90.f);
                             make.top.mas_equalTo(SysHeight/2 - 100.f);
                         }];
                         toWorkBtn.layer.masksToBounds = YES;
                         toWorkBtn.layer.cornerRadius = 45.f;
                         
                         [offWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.width.mas_equalTo(40.f);
                             make.height.mas_equalTo(40.f);
                         }];
                         offWorkBtn.layer.masksToBounds = YES;
                         offWorkBtn.layer.cornerRadius = 20.f;

                         [self.view layoutIfNeeded];
                     }];
}

//下班动画
- (void) offWorkButtonAnimate
{
    [UIView animateWithDuration: 1.f
                     animations:^{
                         [toWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.width.mas_equalTo(40.f);
                             make.height.mas_equalTo(40.f);
                             make.top.mas_equalTo(SysHeight/2 - 50.f);
                         }];
                         toWorkBtn.layer.masksToBounds = YES;
                         toWorkBtn.layer.cornerRadius = 20.f;
                         
                         [offWorkBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                             make.width.mas_equalTo(90.f);
                             make.height.mas_equalTo(90.f);
                         }];
                         offWorkBtn.layer.masksToBounds = YES;
                         offWorkBtn.layer.cornerRadius = 45.f;

                         [self.view layoutIfNeeded];
                     }];
}

#pragma mark - 打卡记录
- (void) clockCalendar
{
    ClockCalendarViewController *clockCalendarVC = [[ClockCalendarViewController alloc] init];
    clockCalendarVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController: clockCalendarVC animated: YES];

//    RecordViewController *recordVC = [[RecordViewController alloc] init];
//    recordVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController: recordVC animated: YES];
}

#pragma mark - 打卡
//上班打卡
- (void) toWorkBtnClick
{
    workTypeStr = @"上班";
    [self handleToOffwork: @""];
}

//下班打卡
- (void) offWorkBtnClick
{
    workTypeStr = @"下班";
    [self handleToOffwork: @""];
}

#pragma mark 打卡处理
- (void) handleToOffwork: (NSString *)remarksStr
{
    NSString *timeStr = [PublicFactory gainDate_YMDHMS_String];
    BOOL result = [[ClockCardDB sharedClockCardDB] addClockCardToDB: timeStr
                                                           workType: workTypeStr
                                                            remarks: remarksStr];
    if (result)
    {
        [SVProgressHUD showSuccessWithStatus: [NSString stringWithFormat: @"%@\n%@打卡成功", timeStr, workTypeStr]];
    }
    else
    {
        [SVProgressHUD showErrorWithStatus: [NSString stringWithFormat: @"%@\n%@打卡失败", timeStr, workTypeStr]];
    }
}

#pragma mark - 长按手势
- (void) toWorkButtonLongPress: (UILongPressGestureRecognizer *)longPress
{
    if ([longPress state] == UIGestureRecognizerStateBegan)
    {
        NSLog(@"上班长按事件");
        workTypeStr = @"上班";
        [self showPopAnimationWithAnimation];
    }
}

- (void) offWorkButtonLongPress: (UILongPressGestureRecognizer *)longPress
{
    if ([longPress state] == UIGestureRecognizerStateBegan)
    {
        NSLog(@"下班长按事件");
        workTypeStr = @"下班";
        [self showPopAnimationWithAnimation];
    }
}

#pragma mark 显示弹框
- (void)showPopAnimationWithAnimation
{
    [customAlertView.remarksTextView setText: @""];
    
    // 1.初始化
    ZJAnimationPopView *popView = [[ZJAnimationPopView alloc] initWithCustomView: customAlertView
                                                                        popStyle: ZJAnimationPopStyleShakeFromTop
                                                                    dismissStyle: ZJAnimationDismissStyleDropToBottom];
    
    // 2.设置属性，可不设置使用默认值，见注解
    // 2.1 显示时点击背景是否移除弹框
    popView.isClickBGDismiss = YES;
    // 2.2 显示时背景的透明度
    popView.popBGAlpha = 0.5f;
    // 2.3 显示时是否监听屏幕旋转
    popView.isObserverOrientationChange = YES;
    // 2.4 显示时动画时长
    popView.popAnimationDuration = 1.25f;
    // 2.5 移除时动画时长
	popView.dismissAnimationDuration = 1.f;
    
    // 2.6 显示完成回调
    popView.popComplete = ^{
        NSLog(@"显示完成");
    };
    // 2.7 移除完成回调
    popView.dismissComplete = ^{
        NSLog(@"移除完成");
    };
    
    // 3.处理自定义视图操作事件
    [self handleCustomActionEnvent: popView];
    
    // 4.显示弹框
    [popView pop];
}

#pragma mark 处理自定义视图操作事件
- (void)handleCustomActionEnvent:(ZJAnimationPopView *)popView
{
    // 在监听自定义视图的block操作事件时，要使用弱对象来避免循环引用
    WeakObj(popView);
    WeakObj(self);
    customAlertView.cannelConfrimActionBlock = ^(BOOL isConfrim, NSString *remarksStr)
    {
        [weakpopView dismiss];
        NSLog(@"点击了%@", isConfrim ? @"确定" : @"取消");
        NSLog(@"remarksStr = %@", remarksStr);
        if (isConfrim)
        {
            [weakself handleRemarks: remarksStr];
        }
    };
}

- (void) handleRemarks: (NSString *)remarksStr
{
    if ([workTypeStr isEqualToString: @"上班"])
    {
        [self handleToOffwork: remarksStr];
    }
    else if ([workTypeStr isEqualToString: @"下班"])
    {
        [self handleToOffwork: remarksStr];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
