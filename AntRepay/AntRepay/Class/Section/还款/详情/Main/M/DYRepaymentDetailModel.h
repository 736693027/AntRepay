//
//  DYRepaymentDetailModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYRepaymentDetailModel : DYModel

@end


/**
 消费
 */
@interface DYRepaymentDetailConsumeModel : DYModel

@property (nonatomic, strong) NSString *online; /**<时间*/
@property (nonatomic, strong) NSString *money; /**<金钱*/
@property (nonatomic, strong) NSString *status; /**<0-未执行，1-处理中，2-处理成功，3-处理失败*/

@end


/**
 还款
 */
@interface DYRepaymentDetailRepayModel : DYModel

/**
 0-待初次消费，11-初次消费中，10-初次消费失败，1-待二次消费，21-二次消费中，20-二次消费失败，2-待还款，30-还款失败，3-已完成
 */
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *money; /**<计划金额*/

@property (nonatomic, assign) BOOL selected; /**<展开/关闭列表*/

@property (nonatomic, strong) NSString *first_time; /**<首次消费时间*/
@property (nonatomic, strong) NSString *first_money; /**<首次消费金额*/
@property (nonatomic, strong) NSString *first_fee_money; /**<首次消费手续费*/
@property (nonatomic, strong) NSString *first_loanno; /**<首次流水号*/
@property (nonatomic, strong) NSString *first_deal_info; /**<首次处理说明*/
@property (nonatomic, strong) NSString *first_order_no; /**<首次单号*/

@property (nonatomic, strong) NSString *second_time; /**<二次消费时间*/
@property (nonatomic, strong) NSString *second_money; /**<二次消费金额*/
@property (nonatomic, strong) NSString *second_fee_money; /**<二次消费手续费*/
@property (nonatomic, strong) NSString *second_loanno; /**<二次流水号*/
@property (nonatomic, strong) NSString *second_deal_info; /**<二次处理说明*/
@property (nonatomic, strong) NSString *second_order_no; /**<二次单号*/

@property (nonatomic, strong) NSString *repayment_time; /**<还款时间*/
@property (nonatomic, strong) NSString *repayment_money; /**<还款金额*/
@property (nonatomic, strong) NSString *repayment_fee_money; /**<款手续费*/
@property (nonatomic, strong) NSString *repayment_loanno; /**<款流水号*/
@property (nonatomic, strong) NSString *repayment_deal_info; /**<款处理说明*/
@property (nonatomic, strong) NSString *repayment_order_no; /**<款单号*/


@end

@interface DYRepaymentPlanInputModel : DYModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *detail;

@end



