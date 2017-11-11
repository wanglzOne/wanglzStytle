//
//  MainViewController.m
//  CustomTabBar
//
//  Created by bhqm on 2017/11/8.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "MainViewController.h"

//xib
#import "UIViewController+ChooseDate.h"

//


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)xibChooseItem:(id)sender {
    [self showChooseDateWithDesc:@"测试" andCurrentDate:[NSDate date] choosed:^(NSDate *chooseDate) {
        DLog(@"%@",chooseDate);
        [SVProgressHUD setMinimumDismissTimeInterval:0.2];
        [SVProgressHUD showSuccessWithStatus:@"shijan"];
    }];
    
}
- (IBAction)codeChooseItem:(id)sender {

    [self showPickerViewWithDataArray:@[@"1",@"2"] title:@"title" commitBlock:^(NSString *string) {
        [SVProgressHUD showInfoWithStatus:string];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
