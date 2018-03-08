//
//  AppDelegate+ShareSDK.m
//  Julong
//
//  Created by 帝云科技 on 2017/8/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "AppDelegate+ShareSDK.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"


#pragma mark - 微信

static NSString *const weixinAppKey = @"wx3c9d1ca28b77b0dd";
static NSString *const weixinAppSecret = @"ddfb7db18f2703787abdcba7aa30867f";
#pragma mark - QQ

static NSString *const QQAppID = @"1106670124";
static NSString *const QQAppKey = @"SGhpSXravqbsATqn";

@implementation AppDelegate (ShareSDK)

- (void)ShareSDKRegist {
    NSArray *platforms = @[
                           @(SSDKPlatformTypeQQ),
                           @(SSDKPlatformTypeWechat)
                           ];
    [ShareSDK registerActivePlatforms:platforms
                             onImport:^(SSDKPlatformType platformType) {
                                 switch (platformType) {
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class]
                                                    tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                          switch (platformType) {
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:QQAppID
                                                       appKey:QQAppKey
                                                     authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:
                                  [appInfo SSDKSetupWeChatByAppId:weixinAppKey
                                                        appSecret:weixinAppSecret];
                                  break;
                              default:
                                  break;
                          }
                      }];
}

@end
