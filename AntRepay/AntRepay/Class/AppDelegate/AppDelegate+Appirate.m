//
//  AppDelegate+Appirate.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/8.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "AppDelegate+Appirate.h"
#import "Appirater.h"

static NSString *const appId = @"";

@implementation AppDelegate (Appirate)

- (void)initAppirate {
    [Appirater setAppId:appId]; /**<appId*/
    [Appirater setDaysUntilPrompt:7]; /**<使用多少天后提示评价*/
    [Appirater setUsesUntilPrompt:10]; /**<使用多少次后提示评价*/
    [Appirater setSignificantEventsUntilPrompt:-1]; /**<重要事件多少次后开始提示评价*/
    [Appirater setTimeBeforeReminding:7]; /**<当用户点击“以后”后多少天开始提示评价*/
    [Appirater setDebug:NO];
    [Appirater appLaunched:YES];
}

@end
