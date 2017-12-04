//
//  ClockCalendarCollectionViewCell.h
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDayModel.h"

@interface ClockCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UILabel *dayLabel;            ///< 日期
@property (nonatomic, strong) IBOutlet UILabel *toWorkTimeLabel;     ///< 上班时间
@property (nonatomic, strong) IBOutlet UILabel *offWorkTimeLabel;    ///< 下班时间

@property (nonatomic, strong) CalendarDayModel *dayModel;


@end
