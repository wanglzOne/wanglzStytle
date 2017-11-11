//
//  UIViewController+ChooseDate.h
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void (^PickerViewCommitBlock)(NSString *string);

@interface UIViewController (ChooseDate)

/**
 弹出选择时间框
 
 @param desc title
 @param currDate 选中的时间
 @param chooseDate 返回选取时间
 */
- (void)showChooseDateWithDesc:(NSString *)desc andCurrentDate:(NSDate *)currDate choosed:(void (^)(NSDate *chooseDate))chooseDate;


//一级
- (void)showPickerViewWithDataArray:(NSArray *)array title:(NSString *)title  commitBlock:(void (^)(NSString *string))commitBlock;

/*
//两级
- (void)showChooseDateWithDesc:(NSString *)desc commitBlock:(void (^)(NSString *string1,NSString *string2))commitBlock;
- (void)showChooseDateWithDesc:(NSString *)desc AndDataSource:(NSArray *)dataAry commitBlock:(void (^)(NSString *string1,NSString *string2))commitBlock;

//三级
- (void)showChooseDateWithTitle:(NSString *)title commitBlock:(void (^)(NSString *string1,NSString *string2,NSString *string3))commitBlock;

*/



@end
