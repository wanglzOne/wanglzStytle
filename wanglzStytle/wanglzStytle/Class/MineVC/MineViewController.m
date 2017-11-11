//
//  MineViewController.m
//  CustomTabBar
//
//  Created by bhqm on 2017/11/8.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@property (nonatomic,strong) WKWebView *wkWeb;


@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"web广告";
    NSString *showAdsUrl = @"https://www.baidu.com";
    [self.wkWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:showAdsUrl]]];
    
}

-(WKWebView *)wkWeb{
    if (!_wkWeb) {
        _wkWeb = [[WKWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_wkWeb];
    }
    return _wkWeb;
}

@end
