//
//  DYViewController+PVStatistics.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController+PVStatistics.h"

static NSTimeInterval _appearTimeInterval;
static NSTimeInterval _disappearTimeInterval;

@implementation DYViewController (PVStatistics)

- (void)pv_willAppear {
    //获取当前页面名称、进入当前页面的时间，并从本地缓存读取出上一页面
    _appearTimeInterval = 0;
    NSDate *appearDate = [NSDate date];
    _appearTimeInterval = [appearDate timeIntervalSince1970];
    NSString *appearDateString = [NSString stringWithFormat:@"%ld", (NSInteger)[appearDate timeIntervalSince1970]];
    NSLog(@"appearDateString : %@", appearDateString);
}

- (void)pv_willDisappear {
    //获取当前消失时间。
    //停留时间 = 进入页面时间 - 当前消失时间
    //把当前页面保存成本地的“上一页面”，为下个页面取值做准备。
    
    _disappearTimeInterval = 0;
    NSDate *disappearDate = [NSDate date];
    _disappearTimeInterval = [disappearDate timeIntervalSince1970];
    
    [self savePreviousPage];
}

#pragma mark - 把pv提交给服务器
- (void)submitRequest {
    if (![DYAppContext sharedDYAppContext].isLogin) {
        return;
    }
    
    //当前页面名称
    NSString *currentPage = self.navigationItem.title;
    currentPage = [NSString xhq_notEmpty:currentPage] ? currentPage : @"";
    
    //上一页名称
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *previousPage = [ud objectForKey:DY_APP_PREVIOUS_PAGE];
    
    //停留时间
    NSString *residenceTime = [NSString stringWithFormat:@"%.0f", _disappearTimeInterval - _appearTimeInterval];
    
    //用户id、当前页面名称、上一页名称、停留时间
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"current": currentPage,
                            @"previous": previousPage,
                            @"time": residenceTime
                            };
    if ((0)) {
        [DYAppReq GET:@"" param:param callBack:nil];
    }
}

#pragma mark - 当前页保存为“上一页”
- (void)savePreviousPage {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *navTitle = self.navigationItem.title;
    
    if ([NSString xhq_notEmpty:navTitle]) {
        
        [ud setObject:navTitle forKey:DY_APP_PREVIOUS_PAGE];
    }else {
        
        [ud setObject:@"" forKey:DY_APP_PREVIOUS_PAGE];
    }
}

@end
