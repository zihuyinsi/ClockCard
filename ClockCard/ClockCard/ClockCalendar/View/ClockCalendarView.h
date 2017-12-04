//
//  ClockCalendarView.h
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockCalendarView : UIView

/**
 * 当前月的title颜色
 */
@property (nonatomic, strong) UIColor *currentMonthTitleColor;
/**
 * 上月的title颜色
 */
@property (nonatomic, strong) UIColor *lastMonthTitleColor;
/**
 * 下月的title颜色
 */
@property (nonatomic, strong) UIColor *nextMonthTitleColor;

/**
 * 选中的背景颜色
 */
@property (nonatomic, strong) UIColor *selectBackColor;

/**
 * 今日的title颜色
 */
@property (nonatomic, strong) UIColor *todayTitleColor;

/*
 * 是否禁止手势滚动
 */
@property (nonatomic, assign) BOOL isCanScroll;

/*
 * 是否显示上月，下月的按钮
 */
@property (nonatomic, assign) BOOL isShowLastAndNextBtn;

/*
 * 是否显示上月，下月的的数据
 */
@property (nonatomic, assign) BOOL isShowLastAndNextDate;

/**
 * 在配置好上面的属性之后执行
 */
- (void) dealData;

///< 选中回调
@property (nonatomic, copy) void (^selectedBlock)(NSInteger year, NSInteger month, NSInteger day);

@end
