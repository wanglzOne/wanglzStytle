//
//  MacroStatic.h
//  wanglzStytle
//
//  Created by bhqm on 2017/11/9.
//  Copyright © 2017年 wanglz. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const  kBaiduMapKey;//百度地图 key
extern NSString* const  kGaodeMapKey;//高得地图 key
extern NSString* const  KBaseIP;//网络请求IP地址
extern NSString* const  KBaseKeyWord;//IP 地址关键字
extern NSString* const KProductPhoneNumber;

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

// NSUserDefaults
#define  kUserDefaults   [NSUserDefaults standardUserDefaults]

// 自定义NSLog---作用:开发方便调试,发布应用后不使用NSLog 也不删除
#ifdef DEBUG
#define DLog(fmt,...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

/*
 -----------------------------------------------------------------------
 Person *person = [Person new];
 person.name = @"张三";
 WeakSelf(person);
 person.myBlock = ^{
     NSLog(@"person.name = %@",weakperson.name);
 };
 person.myBlock();
 
 ***输出: person.name = 张三 ;同时person对象销毁了 -[Person dealloc]

 但是------在myBlock中延迟输出person.name时就会出现问题----虽然对象销毁了, 输出的值却是null;
 -----------------------------------------------------------------------
 // WeakSelf(person);与StrongSelf(person);一起使用
 
 Person *person = [Person new];
 person.name = @"张三";
 WeakSelf(person);
 person.myBlock = ^{
     StrongSelf(person);
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 NSLog(@"%@",person.name);
     });
 };
 person.myBlock();
 
  ***输出: person.name = 张三 ;同时person对象销毁了 -[Person dealloc]
 **********综上所诉*********
 WeakSelf(person);与StrongSelf(person);一起使用时更安全一些, 不仅可以解决循环引用的问题，也不会导致对象提前释放出现野指针的情况，在block里能输出我们需要的值。
 
 */


//弱引用  // ‘##’ 在宏的定义中可以起到拼接的作用
#define LZWeakSelf(type)  __weak typeof(type) weak##type = type;
//强引用
#define LZStrongSelf(type)  __strong typeof(type) type = weak##type;

// 字符串验证
#define StringSafe(Str) [Str isKindOfClass:[NSString class]]?Str:@""


@interface MacroStatic : NSObject

@end
