//
//  DYBuyUseView.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYBuyUseModel.h"

@interface DYBuyUseView : UIView

@end


/**
 购买金额
 */
@interface DYBuyUseMoneyCell : DYTableViewCell

@property (nonatomic, strong) DYBuyUseModel *useModel;

@end

typedef void(^DYBuyUseBalanceCellBlock)(void);
/**
 账户余额
 */
@interface DYBuyUseBalanceCell : DYTableViewCell

@property (nonatomic, strong) DYBuyUseModel *useModel;

@property (nonatomic, copy) DYBuyUseBalanceCellBlock block;

@end


/**
 提示
 */
@interface DYBuyUseTipCell : DYTableViewCell

@property (nonatomic, strong) DYBuyUseModel *useModel;

@end


/**
 立即股买
 */
@interface DYbuyUseOperationView : UIView

@property (nonatomic, strong) UIButton *operationButton;

@end
