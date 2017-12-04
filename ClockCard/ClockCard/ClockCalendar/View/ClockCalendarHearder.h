//
//  ClockCalendarHearder.h
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockCalendarHearder : UIView

@property (nonatomic, copy) void (^leftButtonClickBlock)(void); ///< 左侧按钮
@property (nonatomic, copy) void (^rightButtonClickBlock)(void);    ///< 右侧按钮

@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, assign) BOOL isShowLeftAndRightBtn; //是否显示左右两侧按钮

@end
