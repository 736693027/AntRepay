//
//  DYMineZhangDanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMineZhangDanVC.h"
#import "DYMineZhangDanCell.h"
#import "DYMineZhangDanModel.h"
#import "DYFilterVC.h"
#import "DYZhangDanDetailVC.h"

@interface DYMineZhangDanVC ()

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;

@property (nonatomic, strong) NSMutableArray *typeArray;

@end

@implementation DYMineZhangDanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"我的账单";
    self.isAddMJFooter = YES;
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kGetImage(@"sxuan")
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(filterAction:)];
}

- (void)dy_request {
    
    [self typeReq];
}

- (void)dy_refresh {
    self.curtentPage = @"1";
    self.isRefresh = YES;
    
    [self billListReq];
}

- (void)dy_loadMore {
    [super dy_loadMore];
    self.curtentPage = [NSString stringWithFormat:@"%ld",[self.curtentPage integerValue] + 1];
    [self billListReq];
}

#pragma mark - 类型请求
- (void)typeReq {
    [self dy_HUDBGShow];
    [DYAppReq GET:_url_money_type param:nil callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self.typeArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *type = responseObject[@"type"];
                for (NSDictionary *list in type) {
                    DYMineZhangDanTypeModel *model = [DYMineZhangDanTypeModel mj_objectWithKeyValues:list];
                    [self.typeArray addObject:model];
                }
            }
        }
        [self billListReq];
    }];
}

#pragma mark - 账单列表请求
- (void)billListReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"type": self.type,
                            @"page": self.curtentPage,
                            @"start_time": self.startTime,
                            @"end_time": self.endTime
                            };
    [DYAppReq GET:_url_zhangDan_list param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = [NSString stringWithFormat:@"%@", responseObject[@"all_page"]];
                for (NSDictionary *dic in responseObject[@"list"]) {
                    DYMineZhangDanModel *model = [DYMineZhangDanModel mj_objectWithKeyValues:dic];
                    [self.dataArray addObject:model];
                }
            }
        }else{
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}


#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYMineZhangDanCell *cell = [DYMineZhangDanCell cellWithTableView:tableView];
    cell.typeArray = self.typeArray;
    DYMineZhangDanModel *model = self.dataArray[indexPath.row];
    [cell setValueWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DYZhangDanDetailVC *vc = [[DYZhangDanDetailVC alloc] init];
    DYMineZhangDanModel *model = self.dataArray[indexPath.row];
    vc.typeArray = self.typeArray;
    vc.idStr = model.mId;
    PUSHVC(vc);
}

// 筛选
- (void)filterAction:(UIBarButtonItem *)sender{
    DYFilterVC *vc = [[DYFilterVC alloc] init];
    vc.filterBlock = ^(NSString *type, NSString *start_time, NSString *end_time) {
        self.type = type;
        self.startTime = start_time;
        self.endTime = end_time;
        [self dy_refresh];
    };
    vc.typeArray = self.typeArray;
    PUSHVC(vc);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYMineZhangDanCell cellHeight];
}

#pragma mark - getter
- (NSMutableArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc]init];
    }
    return _typeArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
