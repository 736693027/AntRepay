//
//  DYSureBtnCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYAddRepaymentPlanModel;
@interface DYSureBtnCell : UITableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, copy) void(^sureBlock)(void);

@end


/**
 还款预览cell （新）
 */
@interface DYPlanPreviewCell : DYTableViewCell

@property (nonatomic, strong) DYAddRepaymentPlanModel *planModel;

@end
