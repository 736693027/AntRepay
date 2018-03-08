//
//  DYAddHuanKuanView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddXiaoFeiPlanView.h"
#import "DYAddRepaymentView.h"

typedef void(^DYAddHuanKuanViewDateBlock)();
@interface DYAddHuanKuanView : UIView

@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *timeView;
@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *typeView;
@property (nonatomic, strong) DYAddRepaymentSingleView *moneyView;
@property (nonatomic, strong) DYAddRepaymentSingleView *chaiView;

@property (nonatomic, copy) void(^addPlanBlock)(NSString *time,NSString *money,NSString *num);    // 增加计划
@property (nonatomic, copy) void(^checkPlanBlock)(NSString *time,NSString *money,NSString *num);    // 查看列表
@property (nonatomic, copy) DYAddHuanKuanViewDateBlock dateBlock;

@end
