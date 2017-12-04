//
//  UIImage+Date.m
//  ClockCard
//
//  Created by lv on 2017/11/24.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "UIImage+Date.h"
#import "CalendarMonthModel.h"

@implementation UIImage (Date)

/**
 *  生成一个图片，根据传入的日期
 *  @param  date    日期
 *  @param  imgSize 图片尺寸
 */
+ (instancetype) imageWithDate: (NSDate *)date
                     imageSize: (CGSize)imgSize
{
    CGFloat scale = 2.f;
    if (SysWidth > 375.f)
    {
        scale = 3.f;
    }
    
    imgSize = CGSizeMake(imgSize.width * scale, imgSize.height * scale);
    CGRect rect = CGRectMake(0.0f, 0.0f, imgSize.width, imgSize.height);
    UIGraphicsBeginImageContext(imgSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithWhite: 0.98 alpha: 1.f].CGColor);
    CGContextFillRect(context, rect);
    
    //上半部分高度
    CGFloat topHeight = imgSize.height * 2 / 7;
    //月份字体
    CGFloat topFontSize = topHeight-2;
    UIFont *topFont = [UIFont fontWithName: @"Chalkduster" size: topFontSize];
    //日期字体
    CGFloat bottomFontSize = imgSize.height * 4 / 7;
    UIFont *bottomFont = [UIFont fontWithName: @"PartyLetPlain" size: bottomFontSize];
    
    //上半部分
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rectangle = CGRectMake(0, 0, imgSize.width, topHeight);
    CGContextAddRect(context, rectangle);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, rectangle);
    
    //日期
    CalendarMonthModel *model = [[CalendarMonthModel alloc] initWithDate: date];
    NSString *monthStr = [NSString stringWithFormat: @"%ld月", (long)model.month];
    NSString *dayStr = [NSString stringWithFormat: @"%ld", (long)model.day];

    //月份
    NSDictionary *monthAttributes = @{NSFontAttributeName: topFont};
    CGRect monthSizeToFit = [monthStr boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, topFontSize)
                                                   options: NSStringDrawingUsesDeviceMetrics
                                                attributes: monthAttributes
                                                   context: nil];
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetTextDrawingMode(context,kCGTextFill);
    [monthStr drawAtPoint: CGPointMake((imgSize.width - monthSizeToFit.size.width)/2, 0)
           withAttributes:@{NSFontAttributeName: topFont,
                            NSForegroundColorAttributeName: [UIColor whiteColor]
                            }];
    
    //日期
    NSDictionary *attributes = @{NSFontAttributeName: bottomFont};
    CGRect sizeToFit = [dayStr boundingRectWithSize: CGSizeMake(CGFLOAT_MAX, bottomFontSize)
                                           options: NSStringDrawingUsesDeviceMetrics
                                        attributes: attributes
                                           context: nil];
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetTextDrawingMode(context,kCGTextFill);
    [dayStr drawAtPoint: CGPointMake((imgSize.width - sizeToFit.size.width)/2, topHeight + (imgSize.height - topHeight - sizeToFit.size.height)/2)
        withAttributes:@{NSFontAttributeName: bottomFont}];
    
    //图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //retain图片
    UIImage *newImage = [UIImage imageWithCGImage: image.CGImage
                                            scale: scale
                                      orientation: UIImageOrientationUp];
    return newImage;
}

@end
