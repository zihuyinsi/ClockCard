//
//  UIView+L_Frame.h
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (L_Frame)

@property (nonatomic, assign) CGFloat l_x;
@property (nonatomic, assign) CGFloat l_y;
@property (nonatomic, assign) CGFloat l_width;
@property (nonatomic, assign) CGFloat l_height;

@property (nonatomic, assign) CGFloat l_left;
@property (nonatomic, assign) CGFloat l_top;
@property (nonatomic, assign) CGFloat l_right;
@property (nonatomic, assign) CGFloat l_bottom;

@property (nonatomic, assign) CGSize l_size;

@end
