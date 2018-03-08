//
//  DYXiaoFeiPlanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYXiaoFeiPlanVC.h"
#import "DYRepayDetailPlanCell.h"

@interface DYXiaoFeiPlanVC ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation DYXiaoFeiPlanVC

- (void)dealloc {
    [self xhq_removeAllObserveNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    [self xhq_addObserveNotification:DYCardPayPlanCleanNotification];
}

-(void)dy_initUI {
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (self.execution) {
        self.tableView.xhq_height = kScreenHeight - BILIHEIGHT(275) - kNavigationStatusHeight;
    }
    else {
        self.tableView.xhq_height = kScreenHeight - kNavigationStatusHeight - BILIHEIGHT(50);
    }
}

- (void)dy_request {
    NSString *urlString;
    if (!self.execution) {
        XHQHUDSHOW(self.view);
        urlString = _url_pay_done;
    }
    else {
        urlString = _url_pay_plan;
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
                    [self.dataArray addObject:[DYRepaymentDetailConsumeModel mj_objectWithKeyValues:list]];
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

#pragma mark - 处理通知
- (void)xhq_handleNotification:(NSNotification *)notification {
    if ([notification xhq_isNotification:DYCardPayPlanCleanNotification]) {
        [self dy_request];
    }
}


#pragma mark - tableViewD

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYRepayDetailPlanCell *cell = [DYRepayDetailPlanCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count <= indexPath.row) {
        return cell;
    }
    cell.consumeModel = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYRepayDetailPlanCell cellHeight];
}


- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.execution ? 0 : [super verticalOffsetForEmptyDataSet:scrollView];
}

@end
