//
//  ClockCalendarViewController.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCalendarViewController.h"
#import "ClockCalendarView.h"

@interface ClockCalendarViewController ()
{
    ClockCalendarView *clockCalendarView;
}

@end

@implementation ClockCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: [UIColor whiteColor]];
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTranslucent: NO];
    
    clockCalendarView = [[ClockCalendarView alloc] init];
    [clockCalendarView setBackgroundColor: [UIColor whiteColor]];
    [self.view addSubview: clockCalendarView];
    [clockCalendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.left.mas_equalTo(0.f);
        make.right.mas_equalTo(0.f);
        make.bottom.mas_equalTo(0.f);
    }];
    clockCalendarView.currentMonthTitleColor = RGBColor(53, 53, 53);
    clockCalendarView.lastMonthTitleColor = RGBColor( 153, 153, 153);
    clockCalendarView.nextMonthTitleColor =RGBColor(153, 153, 153);
    clockCalendarView.isCanScroll = YES;
    clockCalendarView.isShowLastAndNextBtn = YES;
    clockCalendarView.isShowLastAndNextDate = YES;
    clockCalendarView.todayTitleColor = [UIColor redColor];
    clockCalendarView.selectBackColor = RGBColor(179, 216, 253);
    [clockCalendarView dealData];
    
    clockCalendarView.selectedBlock = ^(NSInteger year, NSInteger month, NSInteger day) {
        NSLog(@"%ld年%ld月%ld日", (long)year, (long)month, (long)day);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
