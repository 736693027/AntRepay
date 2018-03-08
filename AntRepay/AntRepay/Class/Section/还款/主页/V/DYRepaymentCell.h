//
//  DYRepaymentCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTableViewCell.h"
#import "DYRepaymentModel.h"

@interface DYRepaymentCell : DYTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@property (nonatomic, strong) DYRepaymentListModel *listModel;

@end


/** 上下文字的view **/
@interface DYTopBottomView : UIView
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) UILabel *sepatorLabel;
@end
