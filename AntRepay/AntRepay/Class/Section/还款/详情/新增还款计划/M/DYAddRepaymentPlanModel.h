//
//  DYAddRepaymentPlanModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYAddRepaymentPlanModel : DYModel

@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *cardid;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *first_money; /**<初次消费额*/
@property (nonatomic, strong) NSString *second_money; /**<二次消费额*/
@property (nonatomic, strong) NSString *plan_time; /**<计划时间*/
@property (nonatomic, strong) NSString *money; /**<计划金额*/
@property (nonatomic, strong) NSNumber *repayment_money; /**<还款金额*/
@property (nonatomic, strong) NSString *fee_money;  /**<手续费*/


@end

@interface DYAddRepaymentSubmitModel : DYModel

@property (nonatomic, strong) NSNumber *fee_money; /**<手续费*/
@property (nonatomic, strong) NSNumber *min_money; /**<信用卡建议预留额度*/
@property (nonatomic, strong) NSNumber *pay_money; /**<消费金额*/
@property (nonatomic, strong) NSNumber *repayment_money; /**<还款金额*/

@end

@interface DYAddRepaymentPlanBondModel : DYModel

@property (nonatomic, strong) NSNumber *all_money; /**<交易总额*/
@property (nonatomic, strong) NSNumber *fee_money; /**<手续费*/
@property (nonatomic, strong) NSNumber *bond_money; /**<保证金*/
@property (nonatomic, strong) NSNumber *account_money; /**<账户余额*/

@end
