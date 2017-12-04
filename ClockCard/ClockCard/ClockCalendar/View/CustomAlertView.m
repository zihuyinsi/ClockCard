//
//  CustomAlertView.m
//  ClockCard
//
//  Created by lv on 2017/11/21.
//  Copyright © 2017年 lv. All rights reserved.
//

#import "CustomAlertView.h"

@implementation CustomAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)CannelButtonAction:(UIButton *)sender {
    if (self.cannelConfrimActionBlock)
    {
        self.cannelConfrimActionBlock(NO, self.remarksTextView.text);
    }
}

- (IBAction)ConfrimButtonAction:(UIButton *)sender {
    if (self.cannelConfrimActionBlock)
    {
        self.cannelConfrimActionBlock(YES, self.remarksTextView.text);
    }
}
@end
