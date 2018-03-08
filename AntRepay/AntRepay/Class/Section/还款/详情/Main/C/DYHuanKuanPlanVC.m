//
//  DYHuanKuanPlanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYHuanKuanPlanVC.h"
#import "DYRepayDetailPlanCell.h"

@interface DYHuanKuanPlanVC ()<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation DYHuanKuanPlanVC

- (void)dealloc {
    [self xhq_removeAllObserveNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    [self xhq_addObserveNotification:DYCardRepayPlanCleanNotification];
    self.navigationItem.title = @"已执行计划";
}

-(void)dy_initUI {
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self.tableView xhq_registerCell:[DYRepayDetailPlanShowCell class]];
    if (self.execution) {
        self.tableView.xhq_height = kScreenHeight - BILIHEIGHT(275) - kNavigationStatusHeight;
    }
//    else {
//        self.tableView.xhq_height = kScreenHeight - kNavigationStatusHeight - BILIHEIGHT(50);
//    }
}

- (void)dy_request {
    NSString *urlString;
    if (!self.execution) {
        XHQHUDSHOW(self.view);
        urlString = _url_repay_done;
    }
    else {
        urlString = _url_repay_plan;
    }
    
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id};
    [DYAppReq GET:urlString param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self.dataArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                for (NSDictionary *list in listArray) {
                    [self.dataArray addObject:[DYRepaymentDetailRepayModel mj_objectWithKeyValues:list]];
                }
                [self setDataSource];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

- (void)dy_refresh {
    [super dy_refresh];
    if (self.execution) {
        [self xhq_postObserveNotification:DYCardDetailInfoReloadNotification];
    }
}

#pragma mark - 处理通知
- (void)xhq_handleNotification:(NSNotification *)notification {
    if ([notification xhq_isNotification:DYCardRepayPlanCleanNotification]) {
        [self dy_request];
    }
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DYRepaymentDetailRepayModel *model = self.dataArray[section];
    return model.selected ? [self.listArray[section] count] + 1 : 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DYRepayDetailPlanCell *cell = [DYRepayDetailPlanCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArray.count <= indexPath.section) {
            return cell;
        }
        cell.repayModel = self.dataArray[indexPath.section];
        
        @weakify(self);
        cell.block = ^{
            @strongify(self);
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
        };
        return cell;
    }else {
        DYRepayDetailPlanShowCell *cell = [tableView xhq_dequeueCell:[DYRepayDetailPlanShowCell class] indexPath:indexPath];
        if (self.listArray.count <= indexPath.section) {
            return cell;
        }
        if ([self.listArray[indexPath.section] count] <= indexPath.row - 1) {
            return cell;
        }
        cell.inputModel = self.listArray[indexPath.section][indexPath.row - 1];
        cell.hideSeparatorLabel = [self.listArray[indexPath.section] count] != indexPath.row;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [DYRepayDetailPlanCell cellHeight];
    }else {
        return [DYRepayDetailPlanShowCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            DYRepayDetailPlanShowCell *cell = (DYRepayDetailPlanShowCell *)sourceCell;
            if ([self.listArray[indexPath.section] count] > indexPath.row - 1) {
                cell.inputModel = self.listArray[indexPath.section][indexPath.row - 1];
            }
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DYRepaymentDetailRepayModel *model = self.dataArray[indexPath.section];
    model.selected = !model.selected;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.execution ? 0 : [super verticalOffsetForEmptyDataSet:scrollView];
}

#pragma mark - getter
- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc]init];
    }
    return _listArray;
}

#pragma mark - setDataSource
- (void)setDataSource {
    [self.listArray removeAllObjects];
    for (DYRepaymentDetailRepayModel *repayModel in self.dataArray) {
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        DYRepaymentPlanInputModel *model = [DYRepaymentPlanInputModel model];
        model.title = @"初次消费单号";
        model.detail = repayModel.first_order_no;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"初次消费流水号";
        model.detail = repayModel.first_loanno;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"初次消费金额";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.first_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"初次消费手续费";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.first_fee_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"初次消费时间";
        model.detail = [repayModel.first_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm:ss"];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"初次处理说明";
        model.detail = repayModel.first_deal_info;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次消费单号";
        model.detail = repayModel.second_order_no;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次消费流水号";
        model.detail = repayModel.second_loanno;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次消费金额";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.second_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次消费手续费";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.second_fee_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次消费时间";
        model.detail = [repayModel.second_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm:ss"];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"二次处理说明";
        model.detail = repayModel.second_deal_info;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款单号";
        model.detail = repayModel.repayment_order_no;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款流水号";
        model.detail = repayModel.repayment_loanno;
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款金额";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.repayment_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款手续费";
        model.detail = [NSString stringWithFormat:@"￥%@",repayModel.repayment_fee_money];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款时间";
        model.detail = [repayModel.repayment_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm:ss"];
        [mArray addObject:model];
        
        model = [DYRepaymentPlanInputModel model];
        model.title = @"还款处理说明";
        model.detail = repayModel.repayment_deal_info;
        [mArray addObject:model];
        
        [self.listArray addObject:mArray];
    }
}

@end
