//
//  DYUserInstructionsVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYUserInstructionsVC.h"
#import "DYGongGaoCell.h"
#import "DYUserInstrucDetailVC.h"
#import "DYGongGaoModel.h"

@interface DYUserInstructionsVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalPage;
@end

@implementation DYUserInstructionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"用户须知";
    self.isAddMJFooter = YES;
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *params = @{@"page": self.curtentPage};
    [DYAppReq GET:_url_yhXuZhi_list param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = [NSString stringWithFormat:@"%@", responseObject[@"all_page"]];
                for (NSDictionary *dic in responseObject[@"article"]) {
                    DYGongGaoModel *model = [DYGongGaoModel mj_objectWithKeyValues:dic];
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
    DYGongGaoCell *cell = [DYGongGaoCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    DYGongGaoModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYUserInstrucDetailVC *vc = [[DYUserInstrucDetailVC alloc] init];
    DYGongGaoModel *model = self.dataArray[indexPath.row];
    vc.idStr = model.mId;
    PUSHVC(vc);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYGongGaoCell cellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
