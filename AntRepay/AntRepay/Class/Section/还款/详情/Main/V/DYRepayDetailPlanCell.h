//
//  DYRepayDetailPlanCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRepaymentDetailModel.h"


typedef void(^DYRepayDetailPlanCellBlock)(void);
@interface DYRepayDetailPlanCell : UITableViewCell


@property (nonatomic, strong) DYRepaymentDetailConsumeModel *consumeModel;
@property (nonatomic, strong) DYRepaymentDetailRepayModel *repayModel;

@property (nonatomic, copy) DYRepayDetailPlanCellBlock block;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@end


/**
 展开的cell
 */
@interface DYRepayDetailPlanShowCell : DYTableViewCell

@property (nonatomic, strong) DYRepaymentPlanInputModel *inputModel;

@end
