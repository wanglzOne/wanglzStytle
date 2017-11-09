//
//  commTabBar.h
//  CrudeOilThrough
//
//  Created by admin on 2017/9/27.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol commTabBarDelegate <NSObject>

- (void)pushButtonClickAction:(BOOL)selected;

@end

@interface commTabBar : UITabBar

@property (nonatomic, weak) id <commTabBarDelegate> delagate;

@end
