//
//  UIImage+Compress.h
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)
/**
 *  修改图片 尺寸   pix 大小
 *
 *  @param pix <#pix description#>
 *
 *  @return <#return value description#>
 */
- (UIImage*)changeImageWithPix:(CGFloat)pix;

/**
 *  将image 限制在某一个大小范围内（300KB）
 *
 *  @return <#return value description#>
 */
- (NSData*)compressedData;

- (UIImage*)compressedImage;
/**
 *  将图片压缩至指定的大小
 *
 *  @param imageLength 以KB为单位 （jepg 都有一个最小的压缩值 保证图片的清晰度 的情况下 进行压缩）
 *
 *  @return <#return value description#>
 */
- (NSData*)compressedImageWitnLength:(NSInteger)imageLength;

/**
 *  给图片加上时间的水印
 *
 *  @param conStr 文字 当为nil的时候就是系统时间
 *
 *  @return UIImage
 */
- (UIImage*)waterMarkImageContent:(NSString*)conStr;

/**
 *   UIColor -->> UIImage    （将UIColor转化为UIimage）
 *
 *  @param color <#color description#>
 *  @param size  <#size description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage*)renderImageWithColor:(UIColor*)color inSize:(CGSize)size;

@end
