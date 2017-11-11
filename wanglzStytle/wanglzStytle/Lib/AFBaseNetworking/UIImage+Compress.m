//
//  UIImage+Compress.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "UIImage+Compress.h"
#import "UIImage+Property.h"
#define MAX_IMAGEPIX 1024.0 // max pix 200.0px
#define MAX_IMAGEDATA_LEN 1000.0 * 200 // max data length 5K

//100KB --> Image 的 size -->清晰度

@implementation UIImage (Compress)

- (NSData*)compressedImageWitnLength:(NSInteger)imageLength
{
    //    CGSize size = self.size;
    CGFloat quality = [self compressionQuality];
    NSInteger lastLnegth = 0;
    NSData* data = nil;
    while (!data || data.length > MAX_IMAGEDATA_LEN) {

        data = [self compressedData:MAX(quality, 0)];
        if (data.length < lastLnegth + 100 || data.length > lastLnegth - 100) { //已经 不能在压缩了
            break;
        }
        lastLnegth = data.length;
        quality = (quality > 0.2 ? quality - 0.1 : quality / 2);
    }

    return data;
}
- (UIImage*)compressedImage
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= MAX_IMAGEPIX && height <= MAX_IMAGEPIX) {
        // no need to compress.
        return self;
    }
    
    if (width == 0 || height == 0) {
        // void zero exception
        return self;
    }
    
    UIImage* newImage = nil;
    CGFloat widthFactor = MAX_IMAGEPIX / width;
    CGFloat heightFactor = MAX_IMAGEPIX / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (NSData*)compressedData:(CGFloat)compressionQuality
{
    assert(compressionQuality <= 1.0 && compressionQuality >= 0);

    return UIImageJPEGRepresentation(self, compressionQuality);
}

- (CGFloat)compressionQuality
{
    NSData* data = UIImageJPEGRepresentation(self, 1.0);
    return 1.0 / (data.length / MAX_IMAGEDATA_LEN);
    //    if (dataLength > MAX_IMAGEDATA_LEN) {
    //        return 1.0 - MAX_IMAGEDATA_LEN / dataLength;
    //    }
    //    else {
    //        return 1.0;
    //    }
}
#pragma mark - 压缩 图片 大小
- (NSData*)compressedData
{
    CGFloat quality = [self compressionQuality];
    NSInteger lastLnegth = 0;
    NSData* data = nil;
    while (!data || data.length > MAX_IMAGEDATA_LEN) {
        data = [self compressedData:MAX(quality, 0)];
        if (data.length < lastLnegth + 100 || data.length > lastLnegth - 100) { //已经 不能在压缩了
            break;
        }
        lastLnegth = data.length;
        quality = (quality > 0.2 ? quality - 0.1 : quality / 2);
    }
    return data;
}
#pragma mark - 修改图片的边长 最大的
- (UIImage*)changeImageWithPix:(CGFloat)pix
{
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width == 0 || height == 0 || (MAX(width, height) < pix + 10 && MAX(width, height) > pix - 10)) {
        return self;
    }
    UIImage* newImage = nil;
    CGFloat scaleFactor = pix / MAX(width, height);
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;

    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    //pop the context to get back to the default
    UIGraphicsEndImageContext();

    return newImage;
}

#pragma mark - 在右下角 加上 文字水印（nil  时间水印）
- (UIImage*)waterMarkImageContent:(NSString*)conStr
{

    // 1. 获得图像上下文
    UIGraphicsBeginImageContext(self.size);
    // 2. 加载图像， 把图像画在特定区域
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 3. 设置水印文字
    NSString* word;
    if (conStr.length) {
        word = conStr;
    }
    else {
        NSDate* senddate = [NSDate date];
        
        NSDateFormatter* dateformatter = [[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
        
        NSString* locationString = [dateformatter stringFromDate:senddate];
        word = locationString;
    }
    // 颜色  (ios7中设置颜色的方法)
    //ios7之后可用
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentRight;
    NSDictionary* dic = @{

        NSFontAttributeName : [UIFont systemFontOfSize:self.size.height / 50],

        NSParagraphStyleAttributeName : style,

        NSBaselineOffsetAttributeName : [NSNumber numberWithInt:NSLineBreakByWordWrapping],

        NSBackgroundColorAttributeName : [UIColor whiteColor],
        NSForegroundColorAttributeName : (conStr.length ? [UIColor blackColor] : [UIColor redColor]),

    };
    //     画 文字 (rect是相对于图像上得位置)
    //     4. 从图像上下文中获得当前绘制的结果 生产图像
    [word drawInRect:CGRectMake(0, self.size.height - self.size.height / 40, self.size.width, self.size.height / 40)
        withAttributes:dic];
    UIImage* result = UIGraphicsGetImageFromCurrentImageContext();
    // 5. 关闭上下文图像
    UIGraphicsEndImageContext();
    result.isWatermarkForTime = YES;
    return result;
}

#pragma mark - 将 UIColor转化我 UIImage
+ (UIImage*)renderImageWithColor:(UIColor*)color inSize:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

//等比例压缩
- (UIImage*)imageCompressForSize:(UIImage*)sourceImage targetSize:(CGSize)size
{
    UIImage* newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        }
        else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }

    UIGraphicsBeginImageContext(size);

    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();

    if (newImage == nil) {
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();

    return newImage;
}

- (UIImage*)imageCompressForWidth:(UIImage*)sourceImage targetWidth:(CGFloat)defineWidth
{
    UIImage* newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(imageSize, size) == NO) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        }
        else {
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if (newImage == nil) {
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();
    return newImage;
}

@end
