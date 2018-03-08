//
//  UIFont+Ext.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/19.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

//TrebuchetMS-Bold
#define  XHQ_FONT(aSize) [UIFont fontWithName:@"TrebuchetMS" size:aSize]
#define  XHQ_FONTBOLD(aSize) [UIFont fontWithName:@"TrebuchetMS-Bold" size:aSize]

//#define kFont(CGFolat) [UIFont systemFontOfSize:BILIWIDTH(CGFolat)]
//#define kBlodFont(CGFolat) [UIFont boldSystemFontOfSize:BILIWIDTH(CGFolat)]
#define kFont(CGFolat) XHQ_FONT(CGFolat)
#define kBlodFont(CGFolat) XHQ_FONTBOLD(CGFolat)

@interface UIFont (Ext)

+ (instancetype)xhq_font18;
+ (instancetype)xhq_font16;
+ (instancetype)xhq_font14;
+ (instancetype)xhq_font12;
+ (instancetype)xhq_font10;

@end
