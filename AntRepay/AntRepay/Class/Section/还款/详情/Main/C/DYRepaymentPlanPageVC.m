//
//  DYRepaymentPlanPageVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepaymentPlanPageVC.h"
#import "DYHuanKuanPlanVC.h"
#import "DYXiaoFeiPlanVC.h"

@interface DYRepaymentPlanPageVC ()

@end

@implementation DYRepaymentPlanPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    
    self.navigationItem.title = @"已执行计划";
    
//    self.titleArray = @[@"消费计划", @"还款计划"];
    self.titleArray = @[@"还款计划列表"];
    DYXiaoFeiPlanVC *pay = [[DYXiaoFeiPlanVC alloc]init];
    pay.execution = self.execution;
    pay.card_id = self.card_id;
    
    DYHuanKuanPlanVC *repay = [[DYHuanKuanPlanVC alloc]init];
    repay.execution = self.execution;
    repay.card_id = self.card_id;
    
//    [self addChildViewController:pay];
    [self addChildViewController:repay];
}

- (void)dy_initUI {
    [super dy_initUI];
    self.titleView.lineColor = [UIColor clearColor];
}

@end
