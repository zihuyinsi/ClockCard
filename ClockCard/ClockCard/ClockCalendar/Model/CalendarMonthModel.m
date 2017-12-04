//
//  CalendarMonthModel.m
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "CalendarMonthModel.h"
#import "NSDate+Calendar.h"

@implementation CalendarMonthModel

- (instancetype)initWithDate:(NSDate *)date
{
    self = [super init];
    if (self)
    {
        _monthDate = date;
        
        _totalDays = [self setupTotalDays];
        _firstWeekday = [self setupFirstWeekday];
        _year = [self setupYear];
        _month = [self setupMonth];
        _day = [self setupDay];
    }
    
    return self;
}

- (NSInteger)setupTotalDays
{
    return [_monthDate totalDaysInMonth];
}

- (NSInteger)setupFirstWeekday
{
    return [_monthDate firstWeekDayInMonth];
}

- (NSInteger)setupYear
{
    return [_monthDate dateYear];
}

- (NSInteger)setupMonth
{
    return [_monthDate dateMonth];
}

- (NSInteger) setupDay
{
    return [_monthDate dateDay];
}

@end
