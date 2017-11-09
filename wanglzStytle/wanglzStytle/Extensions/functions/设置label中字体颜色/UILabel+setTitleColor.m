//
//  UILabel+setTitleColor.m
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "UILabel+setTitleColor.h"

@implementation UILabel (setTitleColor)

- (void)setTitle:(NSString *)title andColorTitle:(NSString *)colorTitle withColor:(UIColor *)color
{
    NSString* titleStr = title;
    if (![title containsString:colorTitle]) {
        titleStr = [title stringByAppendingString:colorTitle];
    }
    NSMutableAttributedString* noteStr = [[NSMutableAttributedString alloc] initWithString:titleStr ? titleStr : @""];
    NSInteger location = [[noteStr string] rangeOfString:colorTitle].location;
    NSRange redRange = NSMakeRange(location, colorTitle.length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:redRange];
    
    [self setAttributedText:noteStr];
}

@end
