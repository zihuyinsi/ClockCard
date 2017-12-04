//
//  ClockCardDB.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "ClockCardDB.h"
#import <FMDB.h>
#import "CalendarMonthModel.h"

@interface ClockCardDB()
{
    FMDatabase *db;
}

@end

@implementation ClockCardDB

static ClockCardDB *sharedDB = nil;

+ (instancetype) sharedClockCardDB
{
    static dispatch_once_t onceT;
    dispatch_once(&onceT, ^{
        sharedDB = [[ClockCardDB alloc] init];
        [sharedDB openOrCreateDB];
    });
    
    return sharedDB;
}

/*** 打开或创建数据库 */
- (void) openOrCreateDB
{
    //打开数据库，如果不存在则创建数据库文件
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dbPath = [path stringByAppendingPathComponent: @"ClockCardDB.db"];
    db = [FMDatabase databaseWithPath: dbPath];
    if (![db open])
    {
        NSLog(@"数据库打开失败");
    }
    else
    {
        NSLog(@"数据库打开成功");
    }
    
    /*** 创建表 */
    NSString *createT_TimeCard = @"CREATE TABLE IF NOT EXISTS 't_TimeCard' ('punchTime' TEXT NOT NULL, 'workType' TEXT NOT NULL, 'remarks' TEXT, 'year' TEXT, 'month' TEXT, 'day' TEXT, 'reserve' TEXT)";
    [db executeUpdate: createT_TimeCard];
    
    [db close];
}

#pragma mark -
/**
 *  打卡信息入库
 *  @param  punchTimeStr    打卡时间
 *  @param  workTypeStr     打卡类型（上班、下班）
 *  @param  remarksStr      备注
 */
- (BOOL)addClockCardToDB: (NSString *)punchTimeStr
                workType: (NSString *)workTypeStr
                 remarks: (NSString *)remarksStr
{
    [db open];
    
    NSDate *date = [PublicFactory dateFromString_YMDHMS_Str: punchTimeStr];
    CalendarMonthModel *monthModel = [[CalendarMonthModel alloc] initWithDate: date];
    NSString *yearStr = [NSString stringWithFormat: @"%ld", (long)monthModel.year];
    NSString *monthStr = [NSString stringWithFormat: @"%ld", (long)monthModel.month];
    NSString *dayStr = [NSString stringWithFormat: @"%ld", (long)monthModel.day];
    
    BOOL result = [db executeUpdate: @"INSERT INTO t_TimeCard(punchTime, workType, remarks, year, month, day) VALUES (?,?,?,?,?,?)", punchTimeStr, workTypeStr, remarksStr, yearStr, monthStr, dayStr];
    if (result)
    {
        NSLog(@"添加成功");
    }
    else
    {
        NSLog(@"添加失败");
    }
    
    [db close];
    
    return result;
}

/**
 *  查询信息
 *  @param  msgInfo     查询条件
 *  @param  result      查询结果
 */
- (void)selectClockCardFromDBWithMsg: (NSDictionary *)msgInfo
                              result: (void(^)(NSInteger resultCode, NSString *resultMsg, NSArray *resutlArr))result
{
    [db open];
    
    NSString *selectStr = @"SELECT * FROM t_TimeCard";
    if (msgInfo == nil)
    {
    }
    else
    {
        NSArray *keyArr = [msgInfo allKeys];
        //字段名
        NSString *keyStr = @"";
        //字段内容
        NSString *valueStr = @"";
        for (int i = 0; i < [keyArr count]; i ++)
        {
            keyStr = keyArr[i];
            valueStr = msgInfo[keyStr];
            
            if (i == 0)
            {
                selectStr = [selectStr stringByAppendingFormat: @" where %@ = '%@'", keyStr, valueStr];
            }
            else
            {
                selectStr = [selectStr stringByAppendingFormat: @" and %@ = '%@'", keyStr, valueStr];
            }
        }
    }
    
    NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    FMResultSet *res = [db executeQuery: selectStr];
    while ([res next]) {
        NSString *punchTimeStr = [res stringForColumn: @"punchTime"];
        NSString *workTypeStr = [res stringForColumn: @"workType"];
        NSString *remarksStr = [res stringForColumn: @"remarks"];
        NSString *yearStr = [res stringForColumn: @"year"];
        NSString *monthStr = [res stringForColumn: @"month"];
        NSString *dayStr = [res stringForColumn: @"day"];
        NSString *reserveStr = [res stringForColumn: @"reserve"];

        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                             [PublicFactory handleStringNull: punchTimeStr], @"punchTime",
                             [PublicFactory handleStringNull: workTypeStr], @"workType",
                             [PublicFactory handleStringNull: remarksStr], @"remarks",
                             [PublicFactory handleStringNull: yearStr], @"year",
                             [PublicFactory handleStringNull: monthStr], @"month",
                             [PublicFactory handleStringNull: dayStr], @"day",
                             [PublicFactory handleStringNull: reserveStr], @"reserve",
                             nil];
        [dataArr addObject: dic];
    }
    
    [db close];
    
    result(1, @"查询成功", dataArr);
}

/**
 *  查询上下班时间
 */
- (NSString *) selectTo_Off_work: (NSString *)yearStr
                           month: (NSString *)monthStr
                             day: (NSString *)dayStr
                       isRemarks: (BOOL)isRemarks
{
    [db open];
    
    NSString *toworkselectStr = [NSString stringWithFormat: @"SELECT * FROM t_TimeCard where year = '%@' and month = '%@' and day = '%@' and workType = '上班' ORDER BY punchTime ASC LIMIT 1", yearStr, monthStr, dayStr];
    NSString *toworkResultStr = @"";
    NSString *toworkRemarksStr = @"";
    FMResultSet *toworkRes = [db executeQuery: toworkselectStr];
    while ([toworkRes next]) {
        toworkResultStr = [toworkRes stringForColumn: @"punchTime"];
        toworkRemarksStr = [toworkRes stringForColumn: @"remarks"];
    }
    
    NSString *offworkselectStr = [NSString stringWithFormat: @"SELECT * FROM t_TimeCard where year = '%@' and month = '%@' and day = '%@' and workType = '下班' ORDER BY punchTime DESC LIMIT 1", yearStr, monthStr, dayStr];
    NSString *offworkResultStr = @"";
    NSString *offworkRemarksStr = @"";
    FMResultSet *offworkRes = [db executeQuery: offworkselectStr];
    while ([offworkRes next]) {
        offworkResultStr = [offworkRes stringForColumn: @"punchTime"];
        offworkRemarksStr = [offworkRes stringForColumn: @"remarks"];
    }

    [db close];
    
    NSString *resultStr1 = @"";
    NSString *resultStr2 = @"";
    if (isRemarks)
    {
        resultStr1 = [NSString stringWithFormat: @"%@\n%@",toworkResultStr, toworkRemarksStr];
        resultStr2 = [NSString stringWithFormat: @"%@\n%@", offworkResultStr, offworkRemarksStr];
    }
    else
    {
        resultStr1 = toworkResultStr;
        resultStr2 = offworkResultStr;
    }
    
    NSString *resutStr = [NSString stringWithFormat: @"%@&&%@", resultStr1, resultStr2];
    return resutStr;
}

@end
