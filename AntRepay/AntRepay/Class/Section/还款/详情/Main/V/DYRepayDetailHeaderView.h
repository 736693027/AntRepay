//
//  DYRepayDetailHeaderView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/15.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRepaymentModel.h"

@interface DYRepayDetailHeaderView : UIView

- (void)setValueWithModel:(NSArray *)model;

@property (nonatomic, strong) DYRepaymentListModel *detailModel;

@property (nonatomic, strong) UIButton *xiaoFeiBtn; // 消费计划
@property (nonatomic, strong) UIButton *huanKuanBtn; // 还款计划
- (void)xiaoFeiAction:(UIButton *)sender;  // 消费计划
- (void)huanKuanAction:(UIButton *)sender; // 还款计划
@property (nonatomic, copy) void(^xiaoFeiBlock)(void); 
@property (nonatomic, copy) void(^huanKuanBlock)(void);
@property (nonatomic, copy) void(^addPlanBlock)(void); // 新增计划
@end
