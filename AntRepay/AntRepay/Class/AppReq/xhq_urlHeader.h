//
//  xhq_urlHeader.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#ifndef xhq_urlHeader_h
#define xhq_urlHeader_h

//常量
#import "Constant.h"
#import "DYAppContext.h"
#import "DYAppCertification.h"

#define DY_APP_KEY @"dy_app_user_key"
#define DY_APP_KEY_VALUE [[NSUserDefaults standardUserDefaults] objectForKey:DY_APP_KEY]
#define DY_APP_KEY_VALUE_REQ @"userid": DY_APP_KEY_VALUE

#define DY_APP_USER_NAME @"dy_app_user_name"
#define DY_APP_USER_NAME_VALUE [[NSUserDefaults standardUserDefaults] objectForKey:DY_APP_USER_NAME]

#define DY_APP_USER_PASS @"dy_app_user_pass"
#define DY_APP_USER_PASS_VALUE [[NSUserDefaults standardUserDefaults] objectForKey:DY_APP_USER_PASS]

//上一页 记录pv
#define DY_APP_PREVIOUS_PAGE @"dy_app_previous_page"

/*
 返回状态说明：成功返回9999
 */

//地址拼接
//static NSString *const _url_base = @"http://myhb.diyunkeji.com/index.php/Api/";
static NSString *const _url_base = @"http://myhb.sdyipeng.com/index.php/Api/";
static NSString *const _url_end = @".html";


#pragma mark - *******首页

//首页banner
static NSString *const _url_index_banner = @"Index/banner";

//首页公告
static NSString *const _url_index_news = @"Index/news";

//首页-是否有新消息
static NSString *const _url_index_message = @"Index/message";

//判断是否展示首页的按钮
static NSString *const _url_index_apple = @"Index/apple";


#pragma mark - ********信用卡还款

//信用卡列表
static NSString *const _url_creditCard_index = @"CreditCard/index";

//信用卡用户信息
static NSString *const _url_creditCard_member = @"CreditCard/member";

//信用卡添加
static NSString *const _url_creditCard_add = @"CreditCard/add";
//信用卡短信
static NSString *const _url_creditCard_sms = @"CreditCard/sms";

//信用卡详情
static NSString *const _url_creditCard_info = @"CreditCard/info";
//信用卡-删除
static NSString *const _url_creditCard_del = @"CreditCard/dodel";
//信用卡-修改
static NSString *const _url_creditCard_edit = @"CreditCard/doedit";

//信用卡-消费计划
static NSString *const _url_pay_plan = @"Pay/plan";
//信用卡-消费计划已完
static NSString *const _url_pay_done = @"Pay/done";
//信用卡-删除消费计划
static NSString *const _url_pay_del = @"Pay/dodel";
//信用卡-消费计划-计划预览
static NSString *const _url_pay_preview = @"Pay/preview";
//信用卡-消费计划-手续费率
static NSString *const _url_pay_rate = @"Pay/rate";
//信用卡-消费计划-计划提交
static NSString *const _url_pay_add = @"Pay/add";


//生成消费日期-按月
static NSString *const _url_date_month = @"Date/month";
//生成消费日期-按周
static NSString *const _url_date_week = @"Date/week";
//生成消费日期-按天
static NSString *const _url_date_days = @"Date/days";

//信用卡-还款计划
static NSString *const _url_repay_plan = @"Repayment/plan";
//信用卡-还款计划已完
static NSString *const _url_repay_done = @"Repayment/done";
//还款计划解冻（即：删除）
static NSString *const _url_repay_unfreeze = @"Repayment/unfreeze";
//信用卡-还款计划预览清空
static NSString *const _url_repay_clear_preview = @"Repayment/clear_preview";
//信用卡-还款计划预览
static NSString *const _url_repay_preview = @"Repayment/preview";
//信用卡-新增还款计划
static NSString *const _url_repay_add = @"Repayment/add";
//保证金-信息
static NSString *const _url_repay_bond = @"Repayment/bond";
//保证金-支付提交计划
static NSString *const _url_repay_paybond = @"Repayment/paybond";


#pragma mark - ********账本

//账本-列表
static NSString *const _url_order_index = @"Order/index";
//账本-详情
static NSString *const _url_order_info = @"Order/info";


#pragma mark - *******账户

//充值发送验证码
static NSString *const _url_recharge_code = @"Recharge/sms";

//充值
static NSString *const _url_recharge = @"Recharge/dorecharge";

//用户资金情况
static NSString *const _url_userMoney = @"Account/money";

//实名认证发送验证码
static NSString *const _url_shiMing_code = @"Realname/sms";

//检查是否实名认证
static NSString *const _url_aleadyShiMing = @"Realname/verify";

//实名认证提交
static NSString *const _url_shiMing_submit = @"Realname/submit";

//新版激活码认证
static NSString *const _url_verify_coed = @"Realname/verify_code";

//检测是否需要付费
static NSString *const _url_used_check = @"Realname/pay";

//使用权-付费界面
static NSString *const _url_used_info = @"Realname/payinfo";

//使用权-付费
static NSString *const _url_used_pay = @"Realname/dopay";

//推广-我的推广
static NSString *const _url_extend = @"Spread/info";

//推广-我的推广更多
static NSString *const _url_extend_more = @"Spread/myfriend";

#pragma mark - *******登录注册忘记密码


//登录
static NSString *const _url_login = @"Login/dologin";

//注册发送验证码
static NSString *const _url_register_code = @"Register/sms";

//注册
static NSString *const _url_register = @"Register/doreg";
//新版注册
static NSString *const _url_new_regist = @"Register/newreg";

//忘记密码发验证码
static NSString *const _url_forgetPwd_code = @"Password/sms";

//忘记密码提交
static NSString *const _url_forgetPwd = @"Password/back";

//申请贷款web
static NSString *const _url_apply_loan = @"http://real.izhongyin.com/wxportal/loans/loansList?org_id=018100000000";

//申请信用卡web
static NSString *const _url_apply_card = @"http://real.izhongyin.com/wxportal/creditCard/bankCards.do?org_id=018100000000";

//信用卡进度web
static NSString *const _url_card_progress = @"http://real.izhongyin.com/wxportal/creditCard/creditBanksQuery";


#pragma mark - 托管期

//实名-地区选择
static NSString *const _url_realname_area = @"Realname/area";

//接口名称：信用卡绑卡、提现卡绑卡、实名-银行选择
static NSString *const _url_realname_bank = @"Realname/bank";

//提现-绑卡（修改）（新）
static NSString *const _url_bank_bind_edit = @"Cash/bind";

//储蓄卡绑卡短信
static NSString *const _url_bank_bing_sms = @"Cash/sms";

//我的账单-类型
static NSString *const _url_money_type = @"Money/type";

//交易明细-类型
static NSString *const _url_order_type = @"Order/type";

//还款计划列表提交
static NSString *const _url_repayment_dosubmit = @"Repayment/dosubmit";

#pragma mark - 蚂蚁还呗-米刷版修改接口
//实名认证
static NSString *const _url_realname_ms_submit = @"Realname/ms_submit";

//添加信用卡短信
static NSString *const _url_card_ms_sms = @"CreditCard/sms";

//添加信用卡
static NSString *const _url_card_ms_add = @"CreditCard/add";


#endif /* xhq_urlHeader_h */
