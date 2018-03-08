//
//  XHQHud.h
//  Excellence
//
//  Created by 帝云科技 on 2017/7/4.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define XHQHUDSHOW(view) [XHQHud showView:view];
#define XHQHUDBGSHOW(view) [XHQHud showBgView:view];
#define XHQHUDHIDE(view) [XHQHud hideView:view];
#define XHQHUDTEXT(txt) [XHQHud text:txt];
#define XHQHUDFAIL(view) [XHQHud text:@"请求失败，请重试" inView:view];
#define XHQHUDMESSAGE [XHQHud text:responseObject[@"message"]];

@interface XHQHud : NSObject

+ (void)text:(NSString *)text;

+ (void)text:(NSString *)text inView:(UIView *)view;

+ (void)showBgView:(UIView *)view;

+ (void)showView:(UIView *)view;

+ (void)hideView:(UIView *)view;

@end
