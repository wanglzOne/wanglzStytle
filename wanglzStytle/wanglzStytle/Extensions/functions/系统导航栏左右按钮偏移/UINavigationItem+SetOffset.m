//
//  UINavigationItem+SetOffset.m
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "UINavigationItem+SetOffset.h"

@implementation UINavigationItem (SetOffset)

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    if (!leftBarButtonItem) {
        return;
    }
    leftBarButtonItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.leftBarButtonItems = @[negativeSpacer,leftBarButtonItem];
}
- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (!rightBarButtonItem) {
        return;
    }
    [rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    rightBarButtonItem.tintColor = [UIColor whiteColor];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -10;
    self.rightBarButtonItems = @[negativeSpacer,rightBarButtonItem];
}

@end
