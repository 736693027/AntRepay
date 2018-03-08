//
//  DYBooksModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYBooksModel : DYModel

@end

@interface DYBooksTypeModel : DYModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

@end

@interface DYBooksMonthModel : DYModel

@property (nonatomic, strong) NSString *month;
@property (nonatomic, strong) NSArray *order;

@end

@interface DYBooksListModel : DYModel

/**
 1:充值 2:提现 3:还款消费 4:帮你还款 5:纯消费
 改：
 1:还款消费 2:帮你还款
 */
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *bank_num;

@end

@interface DYBooksDetailModel : DYModel

@property (nonatomic, strong) NSString *order_type;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *bank_num;
@property (nonatomic, strong) NSString *order_no;
@property (nonatomic, strong) NSString *deal_info; /**<处理说明*/
@property (nonatomic, strong) NSString *fee_money; /**<手续费*/
@property (nonatomic, strong) NSString *loanno; /**<流水号*/

@end
