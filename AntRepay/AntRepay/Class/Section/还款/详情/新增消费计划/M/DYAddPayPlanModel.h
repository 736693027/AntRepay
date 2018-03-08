//
//  DYAddPayPlanModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

typedef NS_ENUM(NSInteger, payPlanRepeatType) {
    payPlanRepeatTypeDays,
    payPlanRepeatTypeWeek,
    payPlanRepeatTypeMonth
};

@interface DYAddPayPlanModel : DYModel

@property (nonatomic, strong) NSString *startDateString; /**<开始时间*/
@property (nonatomic, strong) NSString *endDateString; /**<结束时间*/
@property (nonatomic, strong) NSString *repeatContent; /**<重复内容*/
@property (nonatomic, strong) NSString *repeatKey; /**<重复内容参数*/
@property (nonatomic, strong) NSString *money; /**<金额*/

@property (nonatomic, assign) payPlanRepeatType repeatType;

@end

@interface DYAddPayPlanpPreviewModel : DYModel

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *time;

@end
