//
//  DYShiMingVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYShiMingVC.h"
#import "DYShiMingRenZhengView.h"
#import "UIViewController+Ext.h"
#import "BRPickerView.h"

@interface DYShiMingVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DYShiMingRenZhengView *renZhengView;
@property (nonatomic, strong) DYAntRealnameView *realnameView;

@property (nonatomic, strong) NSString *codeStr;
@property (nonatomic, strong) NSString *provinceString;
@property (nonatomic, strong) NSString *cityString;
@property (nonatomic, strong) NSString *issuingBankString;

@property (nonatomic, strong) NSMutableArray *provinceArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *bankNameArray;

@end

@implementation DYShiMingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"实名认证";
}

-(void)dy_initUI{
    [super dy_initUI];
//    self.view.backgroundColor = [UIColor xhq_section];
    
    [self.view addSubview:self.realnameView];
    
    return;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, BILIHEIGHT(850));
    _scrollView.showsVerticalScrollIndicator = NO;
    _renZhengView = [[DYShiMingRenZhengView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(850))];
    [_scrollView addSubview:_renZhengView];
    _scrollView.userInteractionEnabled = YES;
    __weak typeof(self) weakSelf = self;
    // 验证码
    _renZhengView.codeBlock = ^(NSString *phone) {
        [weakSelf requestCodeDataWithPhone:phone];
    };
    //发卡银行
    _renZhengView.issuingBlock = ^{
        [weakSelf selectedIssuingBank];
    };
    //选择省份
    _renZhengView.provinceBlock = ^{
        [weakSelf selectedProvice];
    };
    //选择城市
    _renZhengView.cityBlock = ^{
        if ([NSString xhq_notNULL:weakSelf.provinceString]) {
            [weakSelf selectedCity];
        }else {
            XHQHUDTEXT(@"请先选择户籍所在省份");
        }
    };
    // 提交
    _renZhengView.submitBlock = ^(NSString *realname, NSString *idcard, NSString *address, NSString *bank_num, NSString *bank_name, NSString *branch_name, NSString *province, NSString *city, NSString *phone, NSString *code) {
        if (![code isEqualToString:weakSelf.codeStr]) {
            XHQHUDTEXT(@"验证码错误");
            return ;
        }
        [weakSelf requestRenZhengDataWithName:realname idCard:idcard address:address bank_num:bank_num bank_name:bank_name branch_name:branch_name province:province city:city phone:phone];
    };
}

//选择省市数据请求
- (void)areaReq:(NSString *)pid {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{@"pid": pid};
    [DYAppReq GET:_url_realname_area param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                for (NSDictionary *list in listArray) {
                    DYAreaListModel *model = [DYAreaListModel mj_objectWithKeyValues:list];
                    if ([pid isEqualToString:@""]) {
                        [self.provinceArray addObject:model];
                    }else {
                        [self.cityArray addObject:model];
                    }
                }
                NSArray *dataArray = [pid isEqualToString:@""] ? self.provinceArray : self.cityArray;
                [self areaShowWithDataSource:dataArray isCity:![pid isEqualToString:@""]];
            }
        }
    }];
}



// 发送短信验证码
- (void)requestCodeDataWithPhone:(NSString *)phone {
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"phone":phone};
    [DYAppReq GET:_url_shiMing_code param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [Utils getTimeWithButton:_realnameView.codeButton];
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

// 实名认证提交
- (void)requestRenZhengDataWithName:(NSString *)name idCard:(NSString *)idCard address:(NSString *)address bank_num:(NSString *)bank_num bank_name:(NSString *)bank_name branch_name:(NSString *)branch_name province:(NSString *)province city:(NSString *)city phone:(NSString *)phone{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                             @"realname":name,
                             @"idcard":idCard,
                             @"address":address,
                             @"bank_num":bank_num,
                             @"bank_name":bank_name,
                             @"bank_number":self.issuingBankString,
                             @"province":province,
                             @"city":city,
                             @"phone":phone
                             };
    [DYAppReq GET:_url_shiMing_submit param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:3]);
            }else{
                XHQALERTMESSAGE
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 蚂蚁实名认证
- (void)antRealnameReq:(NSString *)name idNum:(NSString *)num {
    [self.view endEditing:YES];
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"realname": name,
                            @"idcard": num
                            };
    [DYAppReq POST:_url_realname_ms_submit param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:3]);
            }else{
                XHQALERTMESSAGE
            }
        }else{
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
                                              self.renZhengView.bankNameView.textField.text = selectValue;
                                              self.issuingBankString = numArray[[nameArray indexOfObject:selectValue]];
                                          }];
    }else {
        [self issuingBankReq];
    }
}

#pragma mark - 选择省份
- (void)selectedProvice {
    if (self.provinceArray.count > 0) {
        [self areaShowWithDataSource:self.provinceArray isCity:NO];
    }else {
        [self areaReq:@""];
    }
}

#pragma mark - 选择市
- (void)selectedCity {
    if (self.cityArray.count > 0) {
        [self areaShowWithDataSource:self.cityArray isCity:YES];
    }else {
        [self areaReq:self.provinceString];
    }
}

#pragma mark - 选择省市弹框
- (void)areaShowWithDataSource:(NSArray *)dataSource isCity:(BOOL)isCity {
    NSMutableArray *idArray = @[].mutableCopy, *nameArray = @[].mutableCopy;
    for (DYAreaListModel *model in dataSource) {
        [idArray addObject:model.ID];
        [nameArray addObject:model.name];
    }
    NSString *title = isCity ? @"请选择户籍所在市" : @"请选择户籍所在省";
    [BRStringPickerView showStringPickerWithTitle:title
                                       dataSource:nameArray
                                  defaultSelValue:nil
                                     isAutoSelect:NO
                                      resultBlock:^(id selectValue) {
                                          if (isCity) {
                                              self.cityString = idArray[[nameArray indexOfObject:selectValue]];
                                              self.renZhengView.shiView.textField.text = selectValue;
                                          }else {
                                              NSString *proviceId = idArray[[nameArray indexOfObject:selectValue]];
                                              if (![proviceId isEqualToString:self.provinceString]) {
                                                  self.cityString = self.renZhengView.shiView.textField.text = nil;
                                                  [self.cityArray removeAllObjects];
                                              }
                                              self.provinceString = proviceId;
                                              self.renZhengView.shengView.textField.text = selectValue;
                                          }
                                      }];
}


#pragma mark - getter
- (DYAntRealnameView *)realnameView {
    if (!_realnameView) {
        _realnameView = [[DYAntRealnameView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationStatusHeight)];
        @weakify(self);
        _realnameView.block = ^(NSString *name, NSString *idStr, NSString *codeStr) {
            @strongify(self);
            if ([codeStr isEqualToString:self.codeStr]) {
                [self antRealnameReq:name idNum:idStr];
            }else {
                XHQHUDTEXT(@"验证码错误");
            }
        };
        _realnameView.codeBlock = ^(NSString *phone) {
            @strongify(self);
            [self requestCodeDataWithPhone:phone];
        };
    }
    return _realnameView;
}

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc]init];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [[NSMutableArray alloc]init];
    }
    return _cityArray;
}

- (NSMutableArray *)bankNameArray {
    if (!_bankNameArray) {
        _bankNameArray = [[NSMutableArray alloc]init];
    }
    return _bankNameArray;
}

@end

@implementation DYAreaListModel

@end

@implementation DYBankNameModel

@end
