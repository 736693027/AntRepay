//
//  DYTiXianRecordVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTiXianRecordVC.h"
#import "DYTiXianRecordCell.h"
#import "DYTiXianRecordModel.h"

@interface DYTiXianRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation DYTiXianRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"提现记录";
    self.isAddMJFooter = YES;
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView xhq_registerCell:[DYTiXianRecordCell class]];
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *params = @{
                             DY_APP_KEY_VALUE_REQ,
                             @"page": self.curtentPage
                             };
    [DYAppReq GET:_url_tiXian_record param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = [NSString stringWithFormat:@"%@", responseObject[@"all_page"]];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    DYTiXianRecordModel *model = [DYTiXianRecordModel mj_objectWithKeyValues:dic];
                    [self.dataArray addObject:model];
                }
            }
        }else{
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTiXianRecordCell *cell = [tableView xhq_dequeueCell:[DYTiXianRecordCell class] indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DYTiXianRecordModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYTiXianRecordCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        DYTiXianRecordCell *cell = (DYTiXianRecordCell *)sourceCell;
        DYTiXianRecordModel *model = self.dataArray[indexPath.row];
        [cell setValueWithModel:model];
    }];
}

@end
