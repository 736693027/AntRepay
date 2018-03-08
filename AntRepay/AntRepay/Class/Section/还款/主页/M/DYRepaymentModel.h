//
//  DYRepaymentModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYRepaymentModel : DYModel

@end

@interface DYRepaymentListModel : DYModel

@property (nonatomic, strong) NSString *bank_name;
@property (nonatomic, strong) NSString *bank_num;
@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *statement_date;
@property (nonatomic, strong) NSString *repayment_date;
@property (nonatomic, strong) NSString *money;

@end


@interface DYRepaymentMemberModel : DYModel

@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *idcard;

@end
