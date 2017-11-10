//
//  commTabBar.m
//  CrudeOilThrough
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "commTabBar.h"

@interface commTabBar ()

@property (nonatomic, strong) UIButton *publishButton;

@end

@implementation commTabBar


- (UIButton *)publishButton {
    if (!_publishButton) {
        _publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publishButton setImage:[UIImage imageNamed:@"bottom-2"] forState:UIControlStateNormal];
        _publishButton.selected = NO;
        // 发布按钮的点击事件
        [_publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_publishButton];
    }
    return _publishButton;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    /**** 设置所有UITabBarButton的frame ****/
    // 按钮的尺寸
    CGFloat TabBarHeight = self.frame.size.height;
    CGFloat TabBarWidth = self.frame.size.width;

    CGFloat buttonW = TabBarWidth / 5;
    
    
    // 适配iPhoneX
    CGFloat buttonH = kiPhoneX ? TabBarHeight - kTabbarSafeBottomMargin: TabBarHeight ;
    
    CGFloat buttonY = 0;
    // 按钮索引
    int buttonIndex = 0;
    
    for (UIView *subview in self.subviews) {
        // 过滤掉非UITabBarButton
        if (subview.class != NSClassFromString(@"UITabBarButton")) continue;
        
        // 设置frame
        CGFloat buttonX = buttonIndex * buttonW;
        // 把发布按钮的位置预留出来
        if (buttonIndex >= 2) { // 右边的2个UITabBarButton
            buttonX += buttonW;
        }
        subview.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 增加索引
        buttonIndex++;
    }
    
    /**** 设置中间的发布按钮的frame ****/
    self.publishButton.frame = CGRectMake(0, 0, buttonW, buttonH);
    
    
    self.publishButton.center = CGPointMake(TabBarWidth * 0.5, buttonH * 0.5);
    
}


- (void)publishClick {
    
    if ([self.delagate performSelector:@selector(pushButtonClickAction:)]) {
        [self.delagate pushButtonClickAction:_publishButton.selected];
    }
}

@end
