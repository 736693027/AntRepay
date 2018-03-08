//
//  DYBankView.h
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/2.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYBankModel.h"

@interface DYBankView : UIView

@end

typedef void(^DYBankCellBlock)(void);
@interface DYBankCell : DYTableViewCell

@property (nonatomic, copy) DYBankCellBlock block;
@property (nonatomic, strong) DYBankModel *bankModel;

@end


typedef void(^DYbankAddCellCodeBlock)(void);
typedef void(^DYbankAddCellDropDownBlock)(void);
/**
 添加银行卡
 */
@interface DYbankAddCell : DYTableViewCell

@property (nonatomic, strong) DYBankAddInputModel *inputModel;

@property (nonatomic, copy) DYbankAddCellCodeBlock codeBlock;
@property (nonatomic, copy) DYbankAddCellDropDownBlock dropDownBlock;

@end
