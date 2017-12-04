//
//  ClockCalendarWeekView.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCalendarWeekView.h"

@implementation ClockCalendarWeekView

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

- (void) setWeekArr:(NSArray *)weekArr
{
    _weekArr = weekArr;
    CGFloat width = self.frame.size.width / [weekArr count];
    for (int i = 0; i < [weekArr count]; i ++)
    {
        UILabel *weekLabel = [[UILabel alloc] init];
        [weekLabel setFrame: CGRectMake( width * i, 0, width, self.frame.size.height)];
        [weekLabel setTextAlignment: NSTextAlignmentCenter];
        [weekLabel setFont: Font(14.f)];
        [weekLabel setTextColor: RGBColor(53.f, 53.f, 53.f)];
        [weekLabel setText: weekArr[i]];
        [self addSubview: weekLabel];
    }
}

@end
