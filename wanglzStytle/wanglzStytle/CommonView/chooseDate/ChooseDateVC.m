//
//  ChooseDateVC.m
///
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "ChooseDateVC.h"

@interface ChooseDateVC ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBottom;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIView *showView;

@end

@implementation ChooseDateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bgView.alpha = 0.0;
    self.toBottom.constant = -190;
    //时间间隔
//    self.picker.minuteInterval = 10;
    
    [self.picker setMinimumDate:[NSDate dateWithTimeIntervalSince1970:0]];
    //设置本地化支持的语言（在此是中文)
    self.picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    //时间显示方式
    self.picker.datePickerMode = UIDatePickerModeDate;
    self.showLabel.text = self.titleDesc;
    
    if (self.currDate) {
        self.picker.date = self.currDate;
    }
    else{
        self.picker.date = [NSDate date];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.38;
        self.toBottom.constant = 0.0;
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)cancel:(id)sender {
    [self dismissConreoller];
}
- (IBAction)sure:(id)sender {
    if (self.chooseDateBlock) {
        self.chooseDateBlock(self.picker.date);
    }
    [self dismissConreoller];
}
- (void)dismissConreoller{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.0;
        self.toBottom.constant = -190;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    if (!CGRectContainsPoint(self.showView.frame, point)) {
        [self dismissConreoller];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
