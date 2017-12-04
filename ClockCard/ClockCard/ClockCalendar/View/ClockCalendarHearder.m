//
//  ClockCalendarHearder.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCalendarHearder.h"

@interface ClockCalendarHearder()
{
    UIButton *leftBtn;
    UIButton *rightBtn;
    UILabel *dateLabel;
}

@end

@implementation ClockCalendarHearder

- (instancetype) init
{
    self = [super init];
    if (self)
    {
        [self initializationClockCalenderHearder];
    }
    return self;
}

/*** 初始化 */
- (void) initializationClockCalenderHearder
{
    //左按钮
    leftBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [leftBtn setImage: [UIImage imageNamed: @"left"]
             forState: UIControlStateNormal];
    [leftBtn addTarget: self
                action: @selector(leftButtonClick)
      forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25.f);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(0.f);
        make.width.mas_equalTo(30.f);
        make.height.mas_equalTo(30.f);
    }];
    
    //右按钮
    rightBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    [rightBtn setImage: [UIImage imageNamed: @"right"]
              forState: UIControlStateNormal];
    [rightBtn addTarget: self
                 action: @selector(rightButtonClick)
       forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25.f);
        make.centerY.mas_equalTo(self.mas_centerY).with.offset(0.f);
        make.width.mas_equalTo(30.f);
        make.height.mas_equalTo(30.f);
    }];
    
    //标题
    dateLabel = [[UILabel alloc] init];
    [dateLabel setTextAlignment: NSTextAlignmentCenter];
    [dateLabel setFont: Font(15.f)];
    [dateLabel setTextColor: RGBColor(53.f, 53.f, 53.f)];
    [self addSubview: dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0.f);
        make.bottom.mas_equalTo(0.f);
        make.left.mas_equalTo(leftBtn.mas_right).with.offset(5.f);
        make.right.mas_equalTo(rightBtn.mas_left).with.offset(-5.f);
    }];
}


#pragma mark - UIButton Click
- (void) leftButtonClick
{
    if (self.leftButtonClickBlock)
    {
        self.leftButtonClickBlock();
    }
}

- (void) rightButtonClick
{
    if (self.rightButtonClickBlock)
    {
        self.rightButtonClickBlock();
    }
}

#pragma mark - setter / getter
- (void) setDateStr:(NSString *)dateStr
{
    _dateStr = dateStr;
    
    [dateLabel setText: dateStr];
}

- (void) setIsShowLeftAndRightBtn:(BOOL)isShowLeftAndRightBtn
{
    _isShowLeftAndRightBtn = isShowLeftAndRightBtn;
    
    leftBtn.hidden = rightBtn.hidden = !isShowLeftAndRightBtn;
}

@end
