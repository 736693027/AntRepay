//
//  UIViewController+versionUpdate.m
//  FinanceOffice
//
//  Created by 帝云科技 on 2017/9/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "UIViewController+versionUpdate.h"

@interface UIViewController ()

@end


static NSString *const appID = @"";

static NSString *const itunesLookup = @"http://itunes.apple.com/cn/lookup?id=%@";
static NSString *const itunesDownload = @"https://itunes.apple.com/cn/app/id%@?mt=8";

@implementation UIViewController (versionUpdate)

- (void)versionUpdate {
    [self appleStoreVersion];
}


- (void)appleStoreVersion {
    NSString *urlString = [NSString stringWithFormat:itunesLookup, appID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
//            获取appStore版本失败
            return ;
        }
        NSError *jsonError = nil;
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&jsonError];
        if (jsonError) {
//            解析json失败
            return;
        }
        [self versionComparison:responseObject];
    }];
    [task resume];
}

- (void)versionComparison:(NSDictionary *)responseObject {
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    NSArray *resultsArray = responseObject[@"results"];
    NSDictionary *appStoreInfo = [resultsArray firstObject];
    NSString *appStoreVersion = appStoreInfo[@"version"];
    
    if([currentVersion compare: appStoreVersion] == NSOrderedAscending) { //升序
        //有新版本
        NSString *msg_1 = [NSString stringWithFormat:@"发现新版本: %@", appStoreVersion];
        NSString *msg_2 = [NSString stringWithFormat:@"\n更新内容:\n%@", appStoreInfo[@"releaseNotes"]];
        NSString *msg_3 = @"\n是否要去更新？";
        NSString *message = [NSString stringWithFormat:@"%@%@%@", msg_1, msg_2, msg_3];
        
        [self alertShowWithMessage:message];
    }
}

- (void)alertShowWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本更新"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionGo = [UIAlertAction actionWithTitle:@"去更新"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                             [self openAppStore];
                                                         });
                                                     }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:actionCancel];
    [alert addAction:actionGo];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)openAppStore {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSString *urlString = [NSString stringWithFormat:itunesDownload, appID];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:urlString, appID]];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

@end
