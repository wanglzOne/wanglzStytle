//
//  UIView+CornerRadius.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//
// 参考网址: http://www.cocoachina.com/ios/20160225/15415.html
#import <UIKit/UIKit.h>

@interface UIView (CornerRadius)

/**
 * 在xib中直接设置
 *  @cornerRadius 设置圆角
 *  @borderWidth   线宽
 *  @borderColor    颜色
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
