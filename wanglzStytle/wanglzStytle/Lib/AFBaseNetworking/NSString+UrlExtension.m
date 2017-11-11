//
//  NSString+UrlExtension.m
//  CrudeOilThrough
//
//  Created by Apple on 2017/9/11.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import "NSString+UrlExtension.h"

@implementation NSString (UrlExtension)

- (NSString *)url_ex
{
    if ([self hasPrefix:@"http"]) {
        if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)] ) {
            return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        }
        else
        {
            return [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        return self;
    }
    
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)] ) {
        return [[NSString stringWithFormat:@"%@%@%@",KBaseIP,KBaseKeyWord,self] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    else
    {
        return [[NSString stringWithFormat:@"%@%@%@",KBaseIP,KBaseKeyWord,self] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}

- (NSString *)imageUrl_ex
{
    if ([self hasPrefix:@"http"]) {
        return self;
    }
    if ([self hasPrefix:@"/"]) {
        return [NSString stringWithFormat:@"%@%@",KBaseIP,self];
    }
    return [NSString stringWithFormat:@"%@/%@",KBaseIP,self];
}

@end
