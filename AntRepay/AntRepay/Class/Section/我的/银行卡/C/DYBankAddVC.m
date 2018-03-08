//
//  DYBankAddVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/2.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYBankAddVC.h"
#import "DYBankView.h"
#import "DYShiMingVC.h"
#import "BRPickerView.h"

@interface DYBankAddVC ()

@property (nonatomic, strong) NSString *codeString;
@property (nonatomic, strong) NSString *issuingBankString;
@property (nonatomic, strong) NSMutableArray *bankNameArray;

@end

@implementation DYBankAddVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = self.isEdit ? @"修改储蓄卡" : @"添加储蓄卡";
    
    [self setDataSource];
}

- (void)dy_initUI {
    [super dy_initUI];
    
    self.tableView.tableFooterView = [self tableFooterView];
    [self.tableView xhq_registerCell:[DYbankAddCell class]];
}

- (void)setDataSource {
    [self.dataArray removeAllObjects];
    
    NSMutableArray *arrSection0 = [NSMutableArray array];
    NSMutableArray *arrSection1 = [NSMutableArray array];
    
    DYBankAddInputModel *model = [[DYBankAddInputModel alloc]init];
    model.title = @"真实姓名";
    model.inputString = @"XXX";
    model.disEnabled = YES;
    [arrSection0 addObject:model];
    
    model = [[DYBankAddInputModel alloc]init];
    model.title = @"身份证号";
    model.inputString = @"342222199410100000";
    model.disEnabled = YES;
    [arrSection0 addObject:model];
    
    model = [[DYBankAddInputModel alloc]init];
    model.title = @"银行卡号";
    model.placeholder = @"请输入银行卡号";
    [arrSection1 addObject:model];
    
    model = [[DYBankAddInputModel alloc]init];
    model.title = @"发卡银行";
    model.placeholder = @"请选择发卡银行";
    model.selected = YES;
    [arrSection1 addObject:model];
    
    model = [[DYBankAddInputModel alloc]init];
    model.title = @"手机号码";
    model.placeholder = @"请输入银行预留手机号";
    [arrSection1 addObject:model];
    
    model = [[DYBankAddInputModel alloc]init];
    model.title = @"验证码";
    model.placeholder = @"请输入验证码";
    model.countDown = YES;
    [arrSection1 addObject:model];
    
    [self.dataArray addObject:arrSection0];
    [self.dataArray addObject:arrSection1];
    
    [self.tableView reloadData];
}

- (void)dy_request {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    XHQHUDBGSHOW(self.view);
    [DYAppReq GET:_url_creditCard_member param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                DYBankUserInfoModel *model = [DYBankUserInfoModel mj_objectWithKeyValues:info];
                [self reloadInfoData:model];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)reloadInfoData:(DYBankUserInfoModel *)model {
    DYBankAddInputModel *nameModel = [self.dataArray firstObject][0];
    nameModel.inputString = model.realname;
    
    DYBankAddInputModel *idModel = [self.dataArray firstObject][1];
    idModel.inputString = model.idcard;
    
    [self.tableView reloadData];
}

#pragma mark - 获取验证码
- (void)codeSMSReq {
    DYBankAddInputModel *phoneModel = [self.dataArray lastObject][2];
    if (![NSString xhq_phoneFormatCheck:phoneModel.inputString tip:@"手机号码"]) {
        return;
    }
    
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{@"phone": phoneModel.inputString};
    [DYAppReq GET:_url_bank_bing_sms param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                
                XHQHUDTEXT(@"验证码已发送,请注意查收");
                NSDictionary *info = responseObject[@"info"];
                self.codeString = [NSString stringWithFormat:@"%@", info[@"code"]];
                XHQ_Log(@"card sms code: %@", self.codeString);
                
                DYBankAddInputModel *codeModel = [self.dataArray lastObject][3];
                codeModel.startCountDown = YES;
                [self.tableView reloadData];
                
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

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
                                              DYBankAddInputModel *model = [self.dataArray lastObject][1];
                                              model.inputString = selectValue;
                                              [self.tableView reloadData];
                                              self.issuingBankString = numArray[[nameArray indexOfObject:selectValue]];
                                          }];
    }else {
        [self issuingBankReq];
    }
}

#pragma mark - 保存
- (void)saveButtonClicked {
    DYBankAddInputModel *model = [self.dataArray lastObject][0];
    NSString *bank_number = model.inputString;
    
    model = [self.dataArray lastObject][1];
    NSString *bank_name = model.inputString;
    
    model = [self.dataArray lastObject][2];
    NSString *phone = model.inputString;
    
    model = [self.dataArray lastObject][3];
    NSString *code = model.inputString;
    
    if (![NSString xhq_bankCardFormatCheck:bank_number tip:@"银行卡号"]) {
        return;
    }
    if (![NSString xhq_notEmpty:bank_name tip:@"发卡银行"]) {
        return;
    }
    if (![NSString xhq_phoneFormatCheck:phone tip:@"手机号"]) {
        return;
    }
    if (![NSString xhq_notEmpty:code tip:@"验证码"]) {
        return;
    }
    if (![code isEqualToString:self.codeString]) {
        XHQHUDTEXT(@"验证码填写错误");
        return;
    }
    
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"bank_num": bank_number,
                            @"bank_name": bank_name,
                            @"bank_number": self.issuingBankString,
                            @"phone": phone
                            };
    [DYAppReq POST:_url_bank_bind_edit param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self operationBankSuccess]);
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)operationBankSuccess {
    if (self.block) {
        self.block();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYbankAddCell *cell = [tableView xhq_dequeueCell:[DYbankAddCell class] indexPath:indexPath];
    DYBankAddInputModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.inputModel = model;
    
    @weakify(self);
    cell.dropDownBlock = ^{
        @strongify(self);
        [self.view endEditing:YES];
        [self selectedIssuingBank];
    };
    cell.codeBlock = ^{
        @strongify(self);
        [self.view endEditing:YES];
        [self codeSMSReq];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BILIHEIGHT(50);
}


#pragma mark - tableFooterView
- (UIView *)tableFooterView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(120))];
    UIButton *button = [UIButton xhq_buttonFrame:CGRectZero
                                         bgColor:[UIColor xhq_base]
                                      titleColor:[UIColor whiteColor]
                                     borderWidth:0
                                     borderColor:nil
                                    cornerRadius:5
                                             tag:0
                                          target:self
                                          action:@selector(saveButtonClicked)
                                           title:@"保  存"];
    button.xhqFont = [UIFont xhq_font14];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.equalTo(CGSizeMake(BILIWIDTH(350), BILIHEIGHT(37)));
    }];
    return view;
}

- (NSMutableArray *)bankNameArray {
    if (!_bankNameArray) {
        _bankNameArray = [[NSMutableArray alloc]init];
    }
    return _bankNameArray;
}

@end
