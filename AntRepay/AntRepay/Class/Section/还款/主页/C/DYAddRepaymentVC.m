//
//  DYAddRepaymentVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddRepaymentVC.h"
#import "DYAddRepaymentView.h"
#import "BRPickerView.h"
#import "DYRepaymentModel.h"
#import "DYShiMingVC.h"

@interface DYAddRepaymentVC ()

@property (nonatomic, strong) DYAddRepaymentView *addView;

@property (nonatomic, strong) DYRepaymentMemberModel *memberModel;
@property (nonatomic, strong) NSString *cardTermString;
@property (nonatomic, strong) NSString *issuingBankString;
@property (nonatomic, strong) NSString *bindId;
@property (nonatomic, strong) NSMutableArray *bankNameArray;
@property (nonatomic, assign) int timeout;

@end

@implementation DYAddRepaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"添加信用卡";
    _addView = [[DYAddRepaymentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_addView];
    __weak typeof(self) weakSelf = self;
    
    //有效期
    _addView.termBlock = ^{
        [weakSelf selectedCardTerm];
    };
    //发卡银行
    _addView.issuingBlock = ^{
        [weakSelf selectedIssuingBank];
    };
    // 账单日
    _addView.zhangDanRiBlock = ^{
        [BRStringPickerView showStringPickerWithTitle:@"请选择账单日" dataSource:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"] defaultSelValue:@"15" isAutoSelect:NO resultBlock:^(id selectValue) {
            weakSelf.addView.zhangDanView.textField.text = selectValue;
        }];
    };
    // 还款日
    _addView.huanKuanRiBlock = ^{
        [BRStringPickerView showStringPickerWithTitle:@"请选择还款日" dataSource:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"] defaultSelValue:@"15" isAutoSelect:NO resultBlock:^(id selectValue) {
            weakSelf.addView.huanKuanView.textField.text = selectValue;
        }];
    };
    // 添加信用卡
    _addView.addBlock = ^(NSString *realName, NSString *idcard, NSString *yinhangka, NSString *CVN2, NSString *youXiaoQi, NSString *faKa, NSString *zhangDanQi, NSString *huanKuanQi, NSString *phone, NSString *code) {
        NSDictionary *param = @{
                                DY_APP_KEY_VALUE_REQ,
                                @"bank_num": yinhangka,
                                @"bank_name": faKa,
                                @"cvn2": CVN2,
                                @"bank_number": weakSelf.issuingBankString,
                                @"date": weakSelf.cardTermString,
                                @"phone": phone,
                                @"statement": zhangDanQi,
                                @"repayment": huanKuanQi,
                                @"bindId": weakSelf.bindId,
                                @"code": code
                                };
        [weakSelf submitReq:param];
    };
    // 验证码
//    _addView.codeBlock = ^(NSString *num, NSString *cvn2, NSString *date, NSString *phone) {
//        NSDictionary *param = @{
//                                DY_APP_KEY_VALUE_REQ,
//                                @"bank_num": num,
//                                @"cvn2": cvn2,
//                                @"date": weakSelf.cardTermString,
//                                @"phone": phone
//                                };
//        [weakSelf codeSmsReq:param];
//    };
}

- (void)dy_request {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    XHQHUDBGSHOW(self.view);
    [DYAppReq GET:_url_creditCard_member param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.memberModel = [DYRepaymentMemberModel mj_objectWithKeyValues:info];
                self.addView.memberModel = self.memberModel;
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 获取验证码
- (void)codeSmsReq:(NSDictionary *)param {
    XHQHUDSHOW(self.view);
    [DYAppReq GET:_url_card_ms_sms param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDTEXT(@"验证码已发送,请注意查收");
                [self getTimeWithButton:_addView.codeBtn];
                NSDictionary *info = responseObject[@"info"];
                self.bindId = [NSString stringWithFormat:@"%@", info[@"bindId"]];
                [self.addView.codeView.textField becomeFirstResponder];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 提交
- (void)submitReq:(NSDictionary *)param {
    XHQHUDSHOW(self.view);
    [DYAppReq POST:_url_card_ms_add param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        @"信用卡添加成功，请返回查看!!!",
                                        @"确定",
                                        [self.navigationController popViewControllerAnimated:YES]);
            }else {
                XHQALERTMESSAGE
                if ([responseObject[@"code"] isEqualToString:@"0000"]) {
                    _addView.codeView.textField.text = nil;
                    if (_timeout > 0) {
                        _timeout = 0;
                    }
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

//发卡银行获取
- (void)issuingBankReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{};
    [DYAppReq GET:_url_realname_bank param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                for (NSDictionary *list in listArray) {
                    DYBankNameModel *model = [DYBankNameModel mj_objectWithKeyValues:list];
                    [self.bankNameArray addObject:model];
                }
                [self selectedIssuingBank];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}
#pragma mark - 选择发卡银行
- (void)selectedIssuingBank {
    if (self.bankNameArray.count > 0) {
        NSMutableArray *nameArray = @[].mutableCopy, *numArray = @[].mutableCopy;
        for (DYBankNameModel *model in self.bankNameArray) {
            [nameArray addObject:model.name];
            [numArray addObject:model.number];
        }
        [BRStringPickerView showStringPickerWithTitle:@"选择发卡银行"
                                           dataSource:nameArray
                                      defaultSelValue:nil
                                         isAutoSelect:NO
                                          resultBlock:^(id selectValue) {
                                              self.addView.faYiHangView.textField.text = selectValue;
                                              self.issuingBankString = numArray[[nameArray indexOfObject:selectValue]];
                                          }];
    }else {
        [self issuingBankReq];
    }
}

#pragma mark - 有效期选择
- (void)selectedCardTerm {
    [self.view endEditing:YES];
    DYSelectedCardTermView *termView = [[DYSelectedCardTermView alloc]init];
    [termView pop];
    termView.block = ^(NSString *year, NSString *month) {
        _addView.youXiaoQiView.textField.text = [NSString stringWithFormat:@"%@/%@", month, year];
        self.cardTermString = [NSString stringWithFormat:@"%@%@", month, year];
    };
}


#pragma mark - getter
- (DYRepaymentMemberModel *)memberModel {
    if (!_memberModel) {
        _memberModel = [[DYRepaymentMemberModel alloc]init];
    }
    return _memberModel;
}

- (NSMutableArray *)bankNameArray {
    if (!_bankNameArray) {
        _bankNameArray = [[NSMutableArray alloc]init];
    }
    return _bankNameArray;
}

#pragma mark - 倒计时 特殊情况
- (void)getTimeWithButton:(UIButton *)getCodeBtn {
    _timeout = 59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(_timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            // int minutes = timeout / 60;
            int seconds = _timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:[NSString stringWithFormat:@"剩余%@秒",strTime] forState:UIControlStateNormal];
                
                getCodeBtn.userInteractionEnabled = NO;
            });
            _timeout--;
        }
    });
    dispatch_resume(_timer);
}

@end
