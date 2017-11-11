//
//  ChooseDateVC.h
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDateVC : UIViewController

@property (nonatomic, strong) NSString *titleDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *picker;
@property (nonatomic,strong) NSDate *currDate;
@property (nonatomic,strong) void (^chooseDateBlock)(NSDate *);


@end
