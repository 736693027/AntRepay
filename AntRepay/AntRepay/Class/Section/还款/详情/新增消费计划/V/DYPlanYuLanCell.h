//
//  DYPlanYuLanCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddPayPlanModel.h"
#import "DYAddRepaymentPlanModel.h"

@interface DYPlanYuLanCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@property (nonatomic, strong) DYAddPayPlanpPreviewModel *payModel;
@property (nonatomic, strong) DYAddRepaymentPlanModel *repayModel;

// 消费计划列表
- (void)setValueWithModel:(NSArray *)model;

// 还款计划列表
- (void)setValueWithHuanKuanModel:(NSArray *)model;

@end
