//
//  chooseDateSeondVC.h
//  wanglzStytle
//
//  Created by lz on 2017/11/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chooseDateSeondVC : UIViewController

@property (nonatomic, strong) NSString *pickerTitle;

@property (nonatomic, strong) NSArray *DataArray;

@property (nonatomic,strong) void (^chooseItemBlock)(NSString *item);

@end
