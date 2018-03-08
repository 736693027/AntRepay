//
//  DYBaoZhengJinVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBaoZhengJinVC.h"
#import "DYRechargeVC.h"

#import "DYBaoZhengJinCell.h"
#import "DYSureBtnCell.h"
#import "DYAddRepaymentPlanModel.h"
#import "UIViewController+Ext.h"

@interface DYBaoZhengJinVC ()

@property (nonatomic, strong) DYAddRepaymentPlanBondModel *bondModel;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation DYBaoZhengJinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"支付保证金";
    self.titleArray = @[@"交易总金额",@"交易手续费",@"操作资金"];
}

-(void)dy_initUI{
    [super dy_initUI];
}

- (void)dy_request {
    XHQHUDBGSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq GET:_url_repay_bond param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *money = responseObject[@"money"];
                self.bondModel = [DYAddRepaymentPlanBondModel mj_objectWithKeyValues:money];
                [self setDataSource];
            }else {
                XHQHUDMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self.tableView reloadData];
    }];
}

- (void)setDataSource {
    if ([NSString xhq_notEmpty:self.bondModel.all_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%.2f", [self.bondModel.all_money floatValue]]];
    }
    else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.bondModel.fee_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%.2f", [self.bondModel.fee_money floatValue]]];
    }
    else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.bondModel.bond_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%.2f", [self.bondModel.bond_money floatValue]]];
    }
    else {
        [self.dataArray addObject:@"--"];
    }
}

#pragma mark - 提交计划
- (void)submitReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq GET:_url_repay_paybond param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:4]);
                [self xhq_postObserveNotification:DYCardRepayPlanCleanNotification];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 充值
- (void)doRecharge {
    DYRechargeVC *recharge = [[DYRechargeVC alloc]init];
    [self.navigationController pushViewController:recharge animated:YES];
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count > 0 ? 3 : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DYBaoZhengJinCell *cell = [DYBaoZhengJinCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithTitle:self.titleArray[indexPath.row]];
        [cell setValueWithString:self.dataArray[indexPath.row]];
        return cell;
    }else if (indexPath.section == 1){
        DYBaoZhengYuECell *cell = [DYBaoZhengYuECell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithString:self.bondModel.account_money];
        
        @weakify(self);
        cell.block = ^{
            @strongify(self);
            [self doRecharge];
        };
        return cell;
    }else {
        DYSureBtnCell *cell = [DYSureBtnCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        // 确认
        cell.sureBlock = ^{
            @strongify(self);
            JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                        @"确定要提交支付？",
                                        @"确定",
                                        @"取消",
                                        [self submitReq]);
        };
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [DYBaoZhengJinCell cellHeight];
    }else if (indexPath.section == 1){
        return [DYBaoZhengYuECell cellHeight];
    }
    return [DYSureBtnCell cellHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(38))];
        UILabel *lable = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
        [view addSubview:lable];
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left).offset(BILIWIDTH(12));
            make.centerY.equalTo(view.mas_centerY);
        }];
        lable.text = @"选择支付方式";
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return BILIHEIGHT(38);
    }
    return 0.01;
}

#pragma mark - getter
- (DYAddRepaymentPlanBondModel *)bondModel {
    if (!_bondModel) {
        _bondModel = [[DYAddRepaymentPlanBondModel alloc]init];
    }
    return _bondModel;
}

@end
