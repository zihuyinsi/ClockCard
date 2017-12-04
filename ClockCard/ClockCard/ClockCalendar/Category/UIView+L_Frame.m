//
//  UIView+L_Frame.m
//  ClockCard
//
//  Created by lv on 2017/11/20.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "UIView+L_Frame.h"

@implementation UIView (L_Frame)

- (void) setL_x:(CGFloat) l_x{
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(l_x, y, width, height);
}
- (CGFloat) l_x{
    return self.frame.origin.x;
}
- (void) setL_y:(CGFloat) l_y{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, l_y, width, height);
}
- (CGFloat) l_y{
    return self.frame.origin.y;
}
- (void) setL_width:(CGFloat) l_width{
    CGRect frame = self.frame;
    frame.size.width = l_width;
    self.frame = frame;
}
- (CGFloat) l_width{
    return self.frame.size.width;
}

- (void) setL_height:(CGFloat) l_height{
    CGRect frame = self.frame;
    frame.size.height = l_height;
    self.frame = frame;
}

- (CGFloat) l_height{
    return self.frame.size.height;
}


- (void) setL_left:(CGFloat) l_left{
    CGFloat y = self.frame.origin.y;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(l_left, y, width, height);
}
- (CGFloat) l_left{
    return self.frame.origin.x;
}


- (void) setL_top:(CGFloat) l_top{
    CGFloat x = self.frame.origin.x;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    self.frame = CGRectMake(x, l_top, width, height);
}
- (CGFloat) l_top{
    return self.frame.origin.y;
}
- (void) setL_right:(CGFloat) l_right{
    CGRect frame = self.frame;
    frame.origin.x = l_right - frame.size.width;
    self.frame = frame;
}
- (CGFloat) l_right{
    return self.frame.origin.x + self.frame.size.width;
}
- (void) setL_bottom:(CGFloat) l_bottom{
    CGRect frame = self.frame;
    frame.origin.y = l_bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat) l_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGSize) l_size {
    return self.frame.size;
}

- (void)setL_size:(CGSize)L_size {
    CGRect frame = self.frame;
    frame.size = L_size;
    self.frame = frame;
}

@end
