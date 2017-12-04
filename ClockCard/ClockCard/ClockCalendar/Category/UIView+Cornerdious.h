//
//  UIView+Cornerdious.h
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Cornerdious)

-(void)setViewCornerdious: (CGFloat)cornerdious;//设置全部圆角
-(void)setViewCornerdious: (CGFloat)cornerdious
                  Corners: (UIRectCorner)corners;  //设置圆角，设置某个位置的圆角
-(void)setViewBorderWidth: (CGFloat)borderWidth
              borderColor: (UIColor *)borderColor;//设置border 以及color

@end
