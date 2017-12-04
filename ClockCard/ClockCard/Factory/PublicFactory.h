//
//  PublicFactory.h
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicFactory : NSObject

/*** 获取当前时间 yyyy-MM-dd HH:mm:ss */
+ (NSString *)gainDate_YMDHMS_String;

/*** 时间字符串 转 NSDate yyyy-MM-dd HH:mm:ss */
+ (NSDate *)dateFromString_YMDHMS_Str: (NSString *)timeStr;

/*** NSDate 转 字符串 HH:mm */
+ (NSString *)stringFromDate_HM_Date: (NSDate *)date;

/*** 字体 以6为标准，相应的5字号减一，6+字号加一 */
+ (UIFont *) setUpFont: (CGFloat)fontSize;

/*** 是否空字符串 */
+ (BOOL) stringIsNull: (NSString *)string;
/*** 字符串空处理 */
+ (NSString *)handleStringNull: (NSString *)string;
/*** 字符串空处理,替换空字符串 */
+ (NSString *)handleStringNull: (NSString *)string
                 replaceString: (NSString *)replaceStr;


@end
