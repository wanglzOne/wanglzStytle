//
//  UILabel+setTitleColor.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (setTitleColor)
/**
 *  设置 title 的 中的 字体的颜色
 *
 *  @param title      标题
 *  @param colorTitle 有颜色标题
 *  @param color      颜色
 */
- (void)setTitle:(NSString *)title andColorTitle:(NSString *)colorTitle withColor:(UIColor *)color ;

@end
