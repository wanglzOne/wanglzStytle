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

//修改下拉刷新动画
#import "ChangeRefreshAnimationVC.h"

#import "DetailViewController.h"

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
//修改下拉刷新动画
- (IBAction)changeRefreshAnimation:(id)sender {
    ChangeRefreshAnimationVC *changeVC = [[ChangeRefreshAnimationVC alloc] init];
    
    [self.navigationController pushViewController:changeVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//数据加载动画
- (IBAction)loadingData:(id)sender {
    DetailViewController *de = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:de animated:YES];
}



@end
