//
//  UIViewController+ChooseDate.m
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "UIViewController+ChooseDate.h"
#import "ChooseDateVC.h"
#import "chooseDateSeondVC.h"

@implementation UIViewController (ChooseDate)


//选择时间
- (void)showChooseDateWithDesc:(NSString *)desc andCurrentDate:(NSDate *)currDate choosed:(void (^)(NSDate *chooseDate))chooseDate{

    ChooseDateVC *dateVc = [[ChooseDateVC alloc]init];
    dateVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    dateVc.currDate = currDate;
    dateVc.titleDesc = desc;
    dateVc.chooseDateBlock = chooseDate;
    [self presentViewController:dateVc animated:NO completion:nil];
}

//选择item
- (void)showPickerViewWithDataArray:(NSArray *)array title:(NSString *)title  commitBlock:(void (^)(NSString *string))commitBlock{
    
    chooseDateSeondVC *itemVC = [[chooseDateSeondVC alloc]init];
    itemVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    itemVC.pickerTitle = title;
    itemVC.DataArray = array;
    itemVC.chooseItemBlock = commitBlock;
    
    [self presentViewController:itemVC animated:YES completion:nil];
    
}

/*


//二级联动

-(void)showChooseDateWithDesc:(NSString *)desc commitBlock:(void (^)(NSString *, NSString *))commitBlock{
    chooseTwoItemsVC *TwoItemsVC = [[chooseTwoItemsVC alloc]init];
    TwoItemsVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    TwoItemsVC.titleDesc = desc;
//    TwoItemsVC.item1Array
    TwoItemsVC.chooseItemTwoBlock = commitBlock;
    
    [self presentViewController:TwoItemsVC animated:YES completion:nil];

}

-(void)showChooseDateWithDesc:(NSString *)desc AndDataSource:(NSArray *)dataAry commitBlock:(void (^)(NSString *, NSString *))commitBlock{
    chooseTwoItemsVC *TwoItemsVC = [[chooseTwoItemsVC alloc]init];
    TwoItemsVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    TwoItemsVC.titleDesc = desc;
    TwoItemsVC.dataSourceAry = dataAry;
    TwoItemsVC.chooseItemTwoBlock = commitBlock;
    
    [self presentViewController:TwoItemsVC animated:YES completion:nil];
}


//三级
-(void)showChooseDateWithTitle:(NSString *)title commitBlock:(void (^)(NSString *, NSString *, NSString *))commitBlock{
    chooseThreeItemsVC *threeItemsVC = [[chooseThreeItemsVC alloc] init];
    threeItemsVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    threeItemsVC.titleDesc = title;
    threeItemsVC.chooseThreeItemBlock = commitBlock;
    
    [self presentViewController:threeItemsVC animated:YES completion:nil];
}

*/

@end
