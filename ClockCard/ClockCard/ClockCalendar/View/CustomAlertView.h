//
//  CustomAlertView.h
//  ClockCard
//
//  Created by lv on 2017/11/21.
//  Copyright © 2017年 lv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarksTextView;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *confrimBtn;

@property (nonatomic, copy) void (^cannelConfrimActionBlock)(BOOL isConfrim, NSString *remarksStr);

- (IBAction)CannelButtonAction:(UIButton *)sender;
- (IBAction)ConfrimButtonAction:(UIButton *)sender;



@end
