//
//  chooseDateSeondVC.m
//  wanglzStytle
//
//  Created by lz on 2017/11/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "chooseDateSeondVC.h"

@interface chooseDateSeondVC ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *bg;
@property (weak, nonatomic) IBOutlet UILabel *showTitle;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toBottom;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, assign) NSInteger selectedRow;
@property (strong, nonatomic)NSDictionary *textAttributes;

@end

@implementation chooseDateSeondVC

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.bg.alpha = 0.0;
    self.toBottom.constant = -190;
    self.dataArr = [NSMutableArray arrayWithArray:self.DataArray];
    [self.picker reloadAllComponents];
    self.selectedRow = 0;
    self.showTitle.text = self.pickerTitle;
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.bg.alpha = 0.38;
        self.toBottom.constant = 0.0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataArr.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc]init];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    
    NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:self.dataArr[row] attributes:self.textAttributes];
    label.attributedText = attStr;
    return label;
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataArr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedRow = row;
}

- (IBAction)cancleButtonAction:(UIButton *)sender {
    [self dismissConreoller];

}
- (IBAction)sureButtonAction:(UIButton *)sender {
    
    
    [self dismissConreoller];

}

- (void)dismissConreoller{
    [UIView animateWithDuration:0.25 animations:^{
        self.bg.alpha = 0.0;
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

- (NSDictionary *)textAttributes {
    if (_textAttributes == nil) {
        _textAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor blackColor]};
    }
    
    return _textAttributes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
