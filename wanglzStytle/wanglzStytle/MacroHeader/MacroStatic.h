//
//  MacroStatic.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma  mark ----------屏幕高度相关的宏定义----------

// 屏幕宽及高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
// ViewController的Height及Width
#define kViewControllerWidth    (self.view.bounds.size.width)
#define kViewControllerHeight   (self.view.bounds.size.height)
// iPhone6下的宽度
#define KHEIGHT_6(kWidth) [UIScreen mainScreen].bounds.size.width*kWidth/375.0
// 判断是否为iPhoneX
#define  kiPhoneX (KScreenWidth == 375.0f && KScreenHeight == 812.0f ? YES : NO)
// 状态栏高
#define  kStatusBarHeight      (kiPhoneX ? 44.0f : 0)
// 导航条高
#define  kNavigationBarHeight  44.0f
// Tabbar高
#define  kTabbarHeight         (kiPhoneX ? (49.f+34.f) : 49.f)
// Tabbar底部安全距离
#define  kTabbarSafeBottomMargin         (kiPhoneX ? 34.f : 0.f)
// 状态栏和导航条高
#define kStatusBarAndNavigationBarHeight  (kiPhoneX ? 88.f : 64.f)
//
#define kViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})
#pragma  mark ----------颜色值和沙盒相关的宏----------

#define RGBColor(r, g, b)           RGBAColor((r), (g), (b), 1.0f)
#define RGBAColor(r, g, b, a)       [UIColor colorWithRed:(r)/255.00f green:(g)/255.00f blue:(b)/255.00f alpha:(a)]

// 16进制转RGB ---0xf0f0f0(背景色) 0xe0e0e0(分割线色)
#define HexAlphaColor(x, a)         [UIColor colorWithRed:((float)(((x) & 0xFF0000) >> 16))/255.0f \
green:((float)(((x) & 0xFF00) >> 8))/255.0f \
blue:((float)((x) & 0xFF))/255.0f \
alpha:(a)]

// 获取Documents目录路径 stringByAppendingPathComponent--好处: 不用再 ImageAndVideos前加 /
#define kDocumentDirectory   \
[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"fileName"]

#pragma  mark ----------通知相关的宏定义----------

#define kNotificationAdd(anObserver, aSEL, noteName, anObj)    [[NSNotificationCenter defaultCenter] \
addObserver:(anObserver) \
selector:(aSEL) \
name:(noteName) \
object:(anObj)]

#define kNotificationRemove(anObserver, notifName, anObj)      [[NSNotificationCenter defaultCenter] \
removeObserver:(anObserver) \
name:(notifName) object:(anObj)]

#define kNotificationRemoveObserver(anObserver)                [[NSNotificationCenter defaultCenter] \
removeObserver:(anObserver)]

#define kNotificationPost(notifName, anObj, anUserInfo)        [[NSNotificationCenter defaultCenter] \
postNotificationName:(notifName) \
object:(anObj) \
userInfo:(anUserInfo)]

#define kNotificationPostOnMainThread(notifName, anObj, anUserInfo) dispatch_async(dispatch_get_main_queue(), ^(void){\
[[NSNotificationCenter defaultCenter] \
postNotificationName:(notifName) \
object:(anObj) \
userInfo:(anUserInfo)];\
});\

#pragma  mark ----------保证在主线程中执行的宏定义----------

#define kdispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#pragma  mark ----------其它类型的宏定义----------

//NSUserDefaults
#define  kUserDefaults   [NSUserDefaults standardUserDefaults]


@interface MacroStatic : NSObject

@end
