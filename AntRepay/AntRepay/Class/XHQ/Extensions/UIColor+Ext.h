//
//  UIColor+Ext.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

//十六进制色值
#define XHQHexColor(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]

//RGBA色值
#define XHQRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//RGB色值
#define XHQRGB(r,g,b) XHQRGBA(r,g,b,1)


#define COLOR_VALUE_BACKGROUND 0xf0f0f0
#define COLOR_VALUE_BASE 0x1f92d1  //主色调  蓝色
#define COLOR_VALUE_RED 0xf27611  //辅色调  红色
#define COLOR_VALUE_GREEN 0x9ec93b  //辅色调  绿色
#define COLOR_VALUE_LINE 0xe5e5e5  //所有线的颜色
#define COLOR_VALUE_HEXB7 0xb7b7b7 //tabBarItem
#define COLOR_VALUE_TITLE 0x242424 //标题
#define COLOR_VALUE_CONTENT 0x707070  //内容
#define COLOR_VALUE_SECTION 0xeff0f1


#define KClearColor [UIColor clearColor]
#define KWhiteColor [UIColor whiteColor]
#define KBlackColor [UIColor blackColor]
#define KGrayColor [UIColor grayColor]
#define KDarkGrayColor [UIColor darkGrayColor]
#define KLightGrayColor [UIColor lightGrayColor]


@interface UIColor (Ext)


+ (instancetype)xhq_base;
+ (instancetype)xhq_background;
+ (instancetype)xhq_red;
+ (instancetype)xhq_green;
+ (instancetype)xhq_hexb7;
+ (instancetype)xhq_line;
+ (instancetype)xhq_aTitle;
+ (instancetype)xhq_content;
+ (instancetype)xhq_section;

@end
