//
//  DYMessageVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMessageVC.h"
#import "DYMessageCell.h"
#import "DYMessageDetailVC.h"
#import "DYMessageModel.h"

@interface DYMessageVC ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation DYMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"消息";
    self.isAddMJFooter = YES;
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                             @"page": self.curtentPage};
    [DYAppReq GET:_url_message_list param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = [NSString stringWithFormat:@"%@", responseObject[@"all_page"]];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    DYMessageModel *model = [DYMessageModel mj_objectWithKeyValues:dic];
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
    DYMessageCell *cell = [DYMessageCell cellWithTableView:tableView];
    DYMessageModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DYMessageDetailVC *vc = [[DYMessageDetailVC alloc] init];
    DYMessageModel *model = self.dataArray[indexPath.row];
    vc.mId = model.mId;
    PUSHVC(vc);
    if ([model.read integerValue] != 1) {
        model.read = @"1";
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        });
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYMessageCell cellHeight];
}


@end
