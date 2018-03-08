//
//  XHQ_Define.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#ifndef XHQ_Define_h
#define XHQ_Define_h

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define XHQ_Log(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define XHQ_Log(...)
#endif


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//-----强弱引用------

//-----@weakify-----

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

//-----@strongify-----

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//宽高

#define XHQ_iPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kTabBarHeight (XHQ_iPhoneX ? 83.f : 49.f)
#define kNavigationBarHeight 44.f
#define kStatusBarHeight (XHQ_iPhoneX ? 44.f : 20.f)
#define kNavigationStatusHeight (kStatusBarHeight + kNavigationBarHeight)
#define kTopHeight (kStatusBarHeight + kNavigationBarHeight)

//屏幕适配宽高比例

#define BILIWIDTH(value) ((value)/375.0f * kScreenWidth)
#define BILIHEIGHT(value) BILIWIDTH(value)
//#define BILIHEIGHT(value) ((value)/667.0f * kScreenHeight)


#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//拼接字符串
#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]

//View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//构建单例类
#define XHQ_SHARED_H(cls) +(instancetype)shared##cls;

#define XHQ_SHARED_M(cls) \
+ (instancetype)shared##cls { \
static cls *obj = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
    obj = [[cls alloc]init]; \
}); \
return obj; \
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



#endif /* XHQ_Define_h */
