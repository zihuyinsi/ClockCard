//
//  ClockCalendarCollectionViewCell.m
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCalendarCollectionViewCell.h"
#import "UIView+Cornerdious.h"

@implementation ClockCalendarCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setDayModel:(CalendarDayModel *)dayModel
{
    _dayModel = dayModel;

    NSString *yearStr = [NSString stringWithFormat: @"%ld", dayModel.year];
    NSString *monthStr = [NSString stringWithFormat: @"%ld", dayModel.month];
    NSString *dayStr = [NSString stringWithFormat:@"%ld", dayModel.day];
    
    //日期显示
    [_dayLabel setText: dayStr];
    
    //查询上下班时间
    NSString *resultStr = [[ClockCardDB sharedClockCardDB] selectTo_Off_work: yearStr
                                                                       month: monthStr
                                                                         day: dayStr
                                                                   isRemarks: NO];
    NSArray *timeArr = [resultStr componentsSeparatedByString: @"&&"];
    if ([timeArr count] > 0)
    {
        if ([PublicFactory stringIsNull: timeArr[0]])
        {
            [_toWorkTimeLabel setText: @""];
            [_offWorkTimeLabel setText: @""];
        }
        else
        {
            NSDate *toworkDate = [PublicFactory dateFromString_YMDHMS_Str: timeArr[0]];
            NSString *toworkStr = [PublicFactory stringFromDate_HM_Date: toworkDate];
            [_toWorkTimeLabel setText: toworkStr];
            [_offWorkTimeLabel setText: @""];
        }
    }
    if ([timeArr count] > 1)
    {
        //上班时间
        if ([PublicFactory stringIsNull: timeArr[0]])
        {
            [_toWorkTimeLabel setText: @""];
        }
        else
        {
            NSDate *toworkDate = [PublicFactory dateFromString_YMDHMS_Str: timeArr[0]];
            NSString *toworkStr = [PublicFactory stringFromDate_HM_Date: toworkDate];
            [_toWorkTimeLabel setText: toworkStr];
            [_offWorkTimeLabel setText: @""];
        }
        
        //下班时间
        if ([PublicFactory stringIsNull: timeArr[1]])
        {
            [_offWorkTimeLabel setText: @""];
        }
        else
        {
            NSDate *offworkDate = [PublicFactory dateFromString_YMDHMS_Str: timeArr[1]];
            NSString *offworkStr = [PublicFactory stringFromDate_HM_Date: offworkDate];
            [_offWorkTimeLabel setText: offworkStr];
        }
    }


    [self setViewCornerdious: 0.f];
    if (dayModel.isNextMonth || dayModel.isLastMonth)
    {
        //上个月或者下个月
        self.userInteractionEnabled = NO;
        if (dayModel.isShowLastAndNextDate)
        {
            self.dayLabel.hidden = NO;
            self.toWorkTimeLabel.hidden = NO;
            self.offWorkTimeLabel.hidden = NO;
            
            if (dayModel.isNextMonth)
            {
                self.dayLabel.textColor = dayModel.nextMonthTitleColor ? dayModel.nextMonthTitleColor : [UIColor colorWithWhite: 0.7f alpha: 1.f];
            }
            if (dayModel.isLastMonth)
            {
                self.dayLabel.textColor = dayModel.nextMonthTitleColor ? dayModel.nextMonthTitleColor : [UIColor colorWithWhite: 0.85f alpha: 1.f];
            }
        }
        else
        {
            self.dayLabel.hidden = YES;
            self.toWorkTimeLabel.hidden = YES;
            self.offWorkTimeLabel.hidden = YES;
        }
    }
    else
    {
        self.dayLabel.hidden = NO;
        self.toWorkTimeLabel.hidden = NO;
        self.offWorkTimeLabel.hidden = NO;
        self.userInteractionEnabled = YES;
        
        if (dayModel.isSelected)
        {
            self.backgroundColor = dayModel.selectBackColor ? dayModel.selectBackColor : RGBColor(237, 245, 255);
            [self setViewCornerdious: 7.f];
        }
        
        self.dayLabel.textColor = dayModel.currentMonthTitleColor ? dayModel.currentMonthTitleColor : RGBColor(53, 53, 53);
        if (dayModel.isToday)
        {
            self.dayLabel.textColor = dayModel.todayTitleColor ? dayModel.todayTitleColor : RGBColor(255, 70, 70);
        }
    }
}

@end
