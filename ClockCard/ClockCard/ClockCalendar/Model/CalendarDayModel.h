//
//  CalendarDayModel.h
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDayModel : NSObject

@property (nonatomic, assign) NSInteger totalDays;      ///< 当前月的天数
@property (nonatomic, assign) NSInteger firstWeekday;   ///< 标示第一天是星期几（0代表周日，1代表周一，以此类推）

@property (nonatomic, assign) NSInteger year;       ///< 所属年份
@property (nonatomic, assign) NSInteger month;      ///< 当前月份
@property (nonatomic, assign) NSInteger day;        ///< 每天所在位置

@property (nonatomic, assign) BOOL isLastMonth;     ///< 上个月
@property (nonatomic, assign) BOOL isNextMonth;     ///< 下个月
@property (nonatomic, assign) BOOL isCurrentMonth;  ///< 当前月
@property (nonatomic, assign) BOOL isToday;         ///< 今天
@property (nonatomic, assign) BOOL isSelected;      ///< 是否被选中

@property (nonatomic, strong) UIColor *currentMonthTitleColor;  ///< 当月title颜色
@property (nonatomic, strong) UIColor *lastMonthTitleColor;     ///< 上月title颜色
@property (nonatomic, strong) UIColor *nextMonthTitleColor;     ///< 下月title颜色
@property (nonatomic, strong) UIColor *todayTitleColor;         ///< 今日title颜色
@property (nonatomic, strong) UIColor *selectBackColor;         ///< 选中背景色

@property (nonatomic, assign) BOOL isShowLastAndNextDate;       ///< 是否显示上个月、下个月数据

@end
