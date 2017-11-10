//
//  ShowAdsViewController.m
//  wanglzStytle
//
//  Created by lz on 2017/11/10.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "ShowAdsViewController.h"



@interface ShowAdsViewController ()
@property (nonatomic,strong) WKWebView *wkWeb;
@end

@implementation ShowAdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"web广告";
    
    [self.wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.showAdsUrl]]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
