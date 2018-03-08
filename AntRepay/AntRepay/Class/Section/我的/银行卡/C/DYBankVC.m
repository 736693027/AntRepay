//
//  DYBankVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/2.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYBankVC.h"
#import "DYBankAddVC.h"

#import "DYBankView.h"

@interface DYBankVC ()

@property (nonatomic, strong) DYBankModel *bankModel;

@end

@implementation DYBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"储蓄卡绑定";
    self.style = DYTableViewStyleGrouped;
}

- (void)dy_initUI {
    [super dy_initUI];
    
    self.view.backgroundColor = [UIColor xhq_section];
    self.tableView.xhq_x = BILIWIDTH(35/2);
    self.tableView.xhq_width = kScreenWidth - BILIWIDTH(35);
    [self.tableView xhq_registerCell:[DYBankCell class]];
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq POST:_url_tiXian_message param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.bankModel = [DYBankModel mj_objectWithKeyValues:info];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self.tableView reloadData];
    }];
}

- (void)editBank:(BOOL)isEdit {
    DYBankAddVC *add = [[DYBankAddVC alloc]init];
    add.edit = isEdit;
    [self.navigationController pushViewController:add animated:YES];
    add.block = ^{
        [self dy_request];
    };
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYBankCell *cell = [tableView xhq_dequeueCell:[DYBankCell class] indexPath:indexPath];
    @weakify(self);
    cell.bankModel = self.bankModel;
    cell.block = ^{
        @strongify(self);
        [self editBank:YES];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BILIHEIGHT(144);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![NSString xhq_notEmpty:self.bankModel.bank_num] ||
        ![NSString xhq_notEmpty:self.bankModel.bank_name]) {
        [self editBank:NO];
    }
    
}

#pragma mark - getter
- (DYBankModel *)bankModel {
    if (!_bankModel) {
        _bankModel = [[DYBankModel alloc]init];
    }
    return _bankModel;
}


@end
