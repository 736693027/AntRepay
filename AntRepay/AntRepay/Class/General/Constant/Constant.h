//
//  Constant.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

//清除信用卡消费计划
FOUNDATION_EXTERN const NSNotificationName DYCardPayPlanCleanNotification;

//清除信用卡还款计划
FOUNDATION_EXTERN const NSNotificationName DYCardRepayPlanCleanNotification;

//刷新执行中计划时，同时刷新信用卡信息
FOUNDATION_EXTERN const NSNotificationName DYCardDetailInfoReloadNotification;

@end
