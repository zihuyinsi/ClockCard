//
//  UIImage+Date.h
//  ClockCard
//
//  Created by lv on 2017/11/24.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Date)

/**
 *  生成一个图片，根据传入的日期
 *  @param  date    日期
 *  @param  imgSize 图片尺寸
 */
+ (instancetype) imageWithDate: (NSDate *)date
                     imageSize: (CGSize)imgSize;

@end
