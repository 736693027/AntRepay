//
//  DYTradeDetailVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTradeDetailVC.h"
#import "DYTradeDetailCell.h"

@interface DYTradeDetailVC ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) DYBooksDetailModel *detailModel;

@end

@implementation DYTradeDetailVC

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"交易时间",@"订单号",@"卡号", @"流水号", @"手续费", @"处理说明"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"账本详情";
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
}

- (void)dy_request {
    
    XHQHUDBGSHOW(self.view);
    NSDictionary *param = @{@"id": self.detail_id};
    [DYAppReq GET:_url_order_info param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.detailModel = [DYBooksDetailModel mj_objectWithKeyValues:info];
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
    if ([NSString xhq_notEmpty:self.detailModel.add_time]) {
        [self.dataArray addObject:[self.detailModel.add_time
                                   xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm"]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.detailModel.order_no]) {
        [self.dataArray addObject:self.detailModel.order_no];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.detailModel.bank_num]) {
        [self.dataArray addObject:self.detailModel.bank_num];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.detailModel.loanno]) {
        [self.dataArray addObject:self.detailModel.loanno];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.detailModel.fee_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"￥%@",self.detailModel.fee_money]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    if ([NSString xhq_notEmpty:self.detailModel.deal_info]) {
        [self.dataArray addObject:self.detailModel.deal_info];
    }else {
        [self.dataArray addObject:@"--"];
    }
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.detailModel ? 2 : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DYTradeDetailCell *cell = [DYTradeDetailCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.detailModel = self.detailModel;
            return cell;
        }else if (indexPath.row == 1){
            DYTradeDetailSecondCell *cell = [DYTradeDetailSecondCell cellWithTableView:tableView];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.typeArray = self.typeArray;
            cell.detailModel = self.detailModel;
            return cell;
        }
    }else if (indexPath.section == 1){
        DYTradeDetailThirdCell *cell = [DYTradeDetailThirdCell cellWithTableView:tableView];
        [cell xhq_noneSelectionStyle];
        [cell setValueWithModel:self.dataArray[indexPath.row]];
        [cell setValueWithTitle:self.titleArray[indexPath.row]];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [DYTradeDetailCell cellHeight];
        }else if (indexPath.row == 1){
            return [DYTradeDetailSecondCell cellHeight];
        }
    }
    return [DYTradeDetailThirdCell cellHeight];
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(12))];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return BILIHEIGHT(12);
    }
    return 0.01;
}

#pragma mark - getter

- (DYBooksDetailModel *)detailModel {
    if (!_detailModel) {
        _detailModel = [[DYBooksDetailModel alloc]init];
    }
    return _detailModel;
}

@end
