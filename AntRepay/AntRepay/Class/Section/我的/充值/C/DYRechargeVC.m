//
//  DYRechargeVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRechargeVC.h"
#import "DYRechargeView.h"
#import "PGDatePicker.h"
#import "DYAddRepaymentView.h"

@interface DYRechargeVC ()<PGDatePickerDelegate>
@property (nonatomic, strong) DYRechargeView *rechargeView;
@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, strong) NSString *cardTermString;
@end

@implementation DYRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestMoneyData];
}

// 查看用户资金情况
- (void)requestMoneyData{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_userMoney param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                _rechargeView.yuLabel.text = [NSString stringWithFormat:@"￥%@",responseObject[@"money"][@"account_money"]];
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"充值";
    _rechargeView = [[DYRechargeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:_rechargeView];
    __weak typeof(self) weakSelf = self;
    // 验证码
    _rechargeView.codeBlock = ^(NSString *phone) {
        [weakSelf requestCodeDataWithPhone:phone];
    };
    
    // 充值
    _rechargeView.rechargeBlock = ^(NSString *money, NSString *kaHao, NSString *CVN2, NSString *youXiaoQi, NSString *phone, NSString *code) {
        [weakSelf requestRechargeDataWithMoney:money banknum:kaHao cvn2:CVN2 date:youXiaoQi phone:phone code:code];
    };
    
    //有效期
    _rechargeView.termBlock = ^{
        [weakSelf selectedCardTerm];
    };
}

// 发送短信验证码
- (void)requestCodeDataWithPhone:(NSString *)phone{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"phone":phone};
    [DYAppReq GET:_url_recharge_code param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [Utils getTimeWithButton:_rechargeView.codeBtn];
                [DYShowView ShowWithText:@"验证码已发送,请注意查收"];
                NSNumber *str = responseObject[@"info"][@"code"];
                _codeStr = NSStringFormat(@"%@",str);
                XHQ_Log(@"%@",responseObject[@"info"]);
            }else{
                XHQALERTMESSAGE
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

// 充值
-(void)requestRechargeDataWithMoney:(NSString *)money banknum:(NSString *)banknum cvn2:(NSString *)cvn2 date:(NSString *)date phone:(NSString *)phone code:(NSString *)code{
    if (![_codeStr isEqualToString:code]) {
        [DYShowView ShowWithText:@"您输入的验证码有误,请重新输入"];
    }else{
        XHQHUDSHOW(self.view);
        NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                                 @"money":money,
                                 @"bank_num":banknum,
                                 @"cvn2":cvn2,
                                 @"date":self.cardTermString,
                                 @"phone":phone
                                 };
        [DYAppReq GET:_url_recharge param:params callBack:^(id responseObject, NSError *error) {
            XHQHUDHIDE(self.view);
            if (!error) {
                if (DYAPPREQSUCCESS) {
                    XHQALERTMESSAGE
                    [self requestMoneyData];
                }else{
                    XHQALERTMESSAGE
                }
            }else{
                XHQHUDFAIL(self.view);
            }
        }];
    }
}

#pragma mark - 有效期选择
- (void)selectedCardTerm {
    [self.view endEditing:YES];
    DYSelectedCardTermView *termView = [[DYSelectedCardTermView alloc]init];
    [termView pop];
    termView.block = ^(NSString *year, NSString *month) {
        _rechargeView.youXiaoQiView.textField.text = [NSString stringWithFormat:@"%@/%@", month, year];
        self.cardTermString = [NSString stringWithFormat:@"%@%@", year, month];
    };
    return;
    
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.titleLabel.text = @"选择有效期";
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    datePicker.confirmButtonTextColor = [UIColor xhq_base];
    datePicker.textColorOfSelectedRow = [UIColor xhq_aTitle];
    datePicker.lineBackgroundColor = [UIColor xhq_content];
    datePicker.minimumDate = [NSDate date];
}

#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *year = [NSString stringWithFormat:@"%ld", dateComponents.year];
    NSString *month = [NSString stringWithFormat:@"%ld", dateComponents.month];
    year = [year substringFromIndex:2];
    month = month.length == 2 ? month : [@"0" stringByAppendingString:month];
    _rechargeView.youXiaoQiView.textField.text = [NSString stringWithFormat:@"%@/%@", month, year];
    self.cardTermString = [NSString stringWithFormat:@"%@%@", year, month];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
