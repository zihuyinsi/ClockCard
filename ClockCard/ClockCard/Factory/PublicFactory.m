//
//  PublicFactory.m
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "PublicFactory.h"

@implementation PublicFactory

/*** 获取当前时间 yyyy-MM-dd HH:mm:ss */
+ (NSString *)gainDate_YMDHMS_String
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *dateStr = [formatter stringFromDate: date];
    NSLog(@"dateStr = %@", dateStr);
    
    return dateStr;
}

/*** 时间字符串 转 NSDate yyyy-MM-dd HH:mm:ss */
+ (NSDate *)dateFromString_YMDHMS_Str: (NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString: timeStr];
    
    return date;
}

/*** NSDate 转 字符串 HH:mm */
+ (NSString *)stringFromDate_HM_Date: (NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateStr = [formatter stringFromDate: date];
    NSLog(@"dateStr = %@", dateStr);
    
    return dateStr;
}

/*** 字体 以6为标准，相应的5字号减一，6+字号加一 */
+ (UIFont *) setUpFont: (CGFloat)fontSize
{
    if ((SysWidth - 375) > 10.f)
    {
        //6+屏幕
        return [UIFont systemFontOfSize: (fontSize+1)];
    }
    else if ((375 - SysWidth) > 10.f)
    {
        //5屏幕
        return [UIFont systemFontOfSize: (fontSize-1)];
    }
    else
    {
        return [UIFont systemFontOfSize: fontSize];
    }
}

/*** 是否空字符串 */
+ (BOOL) stringIsNull: (NSString *)string
{
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([string isKindOfClass: [NSString class]]
        && ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
    {
        return YES;
    }
    return NO;
}

/*** 字符串空处理 */
+ (NSString *)handleStringNull: (NSString *)string
{
    return [PublicFactory handleStringNull: string
                             replaceString: @""];
}
/*** 字符串空处理,替换空字符串 */
+ (NSString *)handleStringNull: (NSString *)string
                 replaceString: (NSString *)replaceStr
{
    if (string == nil || string == NULL)
    {
        return replaceStr;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return replaceStr;
    }
    if ([string isKindOfClass: [NSString class]]
        && ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0))
    {
        return replaceStr;
    }
    return string;
}

@end
