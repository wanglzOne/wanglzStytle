//
//  LoadingDataAnimationVC.h
//  wanglzStytle
//
//  Created by lz on 2017/11/25.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingDataAnimationVC : UIViewController
/**
 *创建加载动画
 */
-(void)loadingAnimationsInView:(UIView *)inView;

/**
 *结束关闭动画
 */
-(void)endAnimations;
@end
