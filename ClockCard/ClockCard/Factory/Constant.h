//
//  Constant.h
//  ClockCard
//
//  Created by lv on 2017/11/17.
//  Copyright © 2017年 lv. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#import "PublicFactory.h"

/*** 屏幕宽、高 */
#define SysWidth    [UIScreen mainScreen].bounds.size.width
#define SysHeight   [UIScreen mainScreen].bounds.size.height

/*** 设置RGB颜色 */
#define RGBColor(r,g,b) [UIColor colorWithRed: (r)/255.f green: (g)/255.f blue: (b)/255.f alpha: 1.f]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed: (r)/255.f green: (g)/255.f blue: (b)/255.f alpha: a]

/*** 字体 */
#define Font(a) [PublicFactory setUpFont: (a)]

/*** 弱引用 */
#define WeakObj(type)  __weak __typeof(type) weak##type = type;

#endif /* Constant_h */
