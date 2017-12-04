//
//  ClockCardDB.h
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockCardDB : NSObject

+ (instancetype) sharedClockCardDB;

/**
 *  打卡信息入库
 *  @param  punchTimeStr    打卡时间
 *  @param  workTypeStr     打卡类型（上班、下班）
 *  @param  remarksStr      备注
 */
- (BOOL)addClockCardToDB: (NSString *)punchTimeStr
                workType: (NSString *)workTypeStr
                 remarks: (NSString *)remarksStr;


/**
 *  查询信息
 *  @param  msgInfo     查询条件
 *  @param  result      查询结果
 */
- (void)selectClockCardFromDBWithMsg: (NSDictionary *)msgInfo
                              result: (void(^)(NSInteger resultCode, NSString *resultMsg, NSArray *resutlArr))result;

/**
 *  查询上下班时间
 */
- (NSString *) selectTo_Off_work: (NSString *)yearStr
                           month: (NSString *)monthStr
                             day: (NSString *)dayStr
                       isRemarks: (BOOL)isRemarks;

@end
