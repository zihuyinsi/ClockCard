//
//  UIView+Cornerdious.m
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "UIView+Cornerdious.h"

@implementation UIView (Cornerdious)

-(void)setViewCornerdious: (CGFloat)cornerdious     //设置全部圆角
{
    self.layer.cornerRadius = cornerdious;
    self.layer.masksToBounds = YES;
}

-(void)setViewCornerdious: (CGFloat)cornerdious
                  Corners: (UIRectCorner)corners  //设置圆角，设置某个位置的圆角
{
    
}

-(void)setViewBorderWidth: (CGFloat)borderWidth
              borderColor: (UIColor *)borderColor //设置border 以及color
{
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}

@end
