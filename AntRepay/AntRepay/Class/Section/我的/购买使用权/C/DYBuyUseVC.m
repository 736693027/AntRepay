//
//  DYBuyUseVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBuyUseVC.h"
#import "DYBuyUseView.h"
#import "DYRechargeVC.h"

@interface DYBuyUseVC ()

@property (nonatomic, strong) DYbuyUseOperationView *tableFooterView;

@property (nonatomic, strong) DYBuyUseModel *useModel;

@end

@implementation DYBuyUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"购买使用权";
}

- (void)dy_initUI {
    [super dy_initUI];
    
    [self.tableView xhq_registerCell:[DYBuyUseMoneyCell class]];
    [self.tableView xhq_registerCell:[DYBuyUseBalanceCell class]];
    [self.tableView xhq_registerCell:[DYBuyUseTipCell class]];
    self.tableView.tableFooterView = self.tableFooterView;
}

- (void)dy_request {
    XHQHUDBGSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_used_info param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.useModel = [DYBuyUseModel mj_objectWithKeyValues:info];
            }else {
                XHQHUDMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - 立即购买操作
- (void)operationButtonClicked {
    if ([self.useModel.use_money floatValue] > [self.useModel.member_money floatValue]) {
        XHQHUDTEXT(@"余额不足，请先充值");
        return;
    }
    NSString *msg = [NSString stringWithFormat:@"确定要购买此APP的终身使用权?"];
    JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                msg,
                                @"确定",
                                @"取消",
                                [self doPayReq]);
}

#pragma mark - 购买请求
- (void)doPayReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_used_pay param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self.navigationController popViewControllerAnimated:YES]);
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.useModel ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            DYBuyUseMoneyCell *cell = [tableView xhq_dequeueCell:[DYBuyUseMoneyCell class] indexPath:indexPath];
            cell.useModel = self.useModel;
            return cell;
        }
        case 1:
        {
            DYBuyUseBalanceCell *cell = [tableView xhq_dequeueCell:[DYBuyUseBalanceCell class] indexPath:indexPath];
            cell.useModel = self.useModel;
            @weakify(self);
            cell.block = ^{
                @strongify(self);
                [self doRecharge]; //充值
            };
            return cell;
        }
        case 2:
        {
            DYBuyUseTipCell *cell = [tableView xhq_dequeueCell:[DYBuyUseTipCell class] indexPath:indexPath];
            cell.useModel = self.useModel;
            return cell;
        }
        default:
            return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            return [DYBuyUseMoneyCell hyb_heightForTableView:tableView config:nil];
        }
        case 1:
        {
            return [DYBuyUseBalanceCell hyb_heightForTableView:tableView config:nil];
        }
        case 2:
        {
            return [DYBuyUseTipCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
                DYBuyUseTipCell *cell = (DYBuyUseTipCell *)sourceCell;
                cell.useModel = self.useModel;
            }];
        }
        default:
            return 0;
    }
}

#pragma mark - getter
- (DYbuyUseOperationView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[DYbuyUseOperationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(150))];
        [_tableFooterView.operationButton xhq_addTarget:self action:@selector(operationButtonClicked)];
    }
    return _tableFooterView;
}

- (DYBuyUseModel *)useModel {
    if (!_useModel) {
        _useModel = [[DYBuyUseModel alloc]init];
    }
    return _useModel;
}

@end
