//
//  DYHuanKuanListVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYHuanKuanListVC.h"
#import "DYPlanYuLanCell.h"
#import "DYSureBtnCell.h"
#import "DYBaoZhengJinVC.h"
#import "DYSubmitPlanAlertView.h"
#import "UIViewController+Ext.h"

@interface DYHuanKuanListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) DYSubmitPlanAlertView *planAlert;

@property (nonatomic, strong) DYAddRepaymentSubmitModel *submitModel;

@end

@implementation DYHuanKuanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"还款计划列表";
}

-(void)dy_initUI{
    [super dy_initUI];
    
    [self.tableView xhq_registerCell:[DYPlanPreviewCell class]];
}

- (UIBarButtonItem *)leftBarButtonItem {
    return [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"return"] style:UIBarButtonItemStylePlain target:self action:@selector(backClicked)];
}

- (UIBarButtonItem *)rightBarButtonItem {
    UIBarButtonItem *clear = [[UIBarButtonItem alloc] initWithTitle:@"清空"
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(qingKongAction:)];
    [clear setTitleTextAttributes:@{NSFontAttributeName:kFont(14),
                                    NSForegroundColorAttributeName:[UIColor xhq_green]}
                         forState:UIControlStateNormal];
    return clear;
}

- (void)dy_request {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq GET:_url_repay_preview param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self.dataArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                for (NSDictionary *list in listArray) {
                    [self.dataArray addObject:[DYAddRepaymentPlanModel mj_objectWithKeyValues:list]];
                }
                NSDictionary *info = responseObject[@"info"];
                self.submitModel = [DYAddRepaymentSubmitModel mj_objectWithKeyValues:info];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        self.planAlert.submitModel = self.submitModel;
        [self.tableView reloadData];
    }];
}

#pragma mark - 清除计划列表
- (void)clearListReq:(BOOL)isBack {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq GET:_url_repay_clear_preview param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                if (isBack) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }else {
                if (isBack) {
                    XHQALERTMESSAGE
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 提交计划
- (void)submitPlanReq {
    XHQHUDHIDE(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq POST:_url_repayment_dosubmit param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:3]);
                [self xhq_postObserveNotification:DYCardRepayPlanCleanNotification];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 清空
- (void)qingKongAction:(UIButton *)sender {
    JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                @"确定要清空数据？",
                                @"确定",
                                @"取消",
                                [self clearListReq:YES]);
}

#pragma mark - 返回
- (void)backClicked {
    JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                @"退出会清空当前数据，确定要退出？",
                                @"确定",
                                @"取消",
                                [self backAction]);
}

- (void)backAction {
    [self clearListReq:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count > 0 ? 2 : 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        DYPlanPreviewCell *cell = [tableView xhq_dequeueCell:[DYPlanPreviewCell class] indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.dataArray.count <= indexPath.row) {
            return cell;
        }
        cell.planModel = self.dataArray[indexPath.row];
        return cell;
    }
    DYSureBtnCell *cell = [DYSureBtnCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    // 确定
    cell.sureBlock = ^{
        [weakSelf.planAlert pop];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [DYPlanPreviewCell hyb_heightForTableView:tableView config:nil];
    }
    return [DYSureBtnCell cellHeight];
}

#pragma mark - getter
- (DYSubmitPlanAlertView *)planAlert {
    if (!_planAlert) {
        _planAlert = [[DYSubmitPlanAlertView alloc]init];
        @weakify(self);
        _planAlert.block = ^{
            @strongify(self);
            [self submitPlanReq];
        };
    }
    return _planAlert;
}

- (DYAddRepaymentSubmitModel *)submitModel {
    if (!_submitModel) {
        _submitModel = [[DYAddRepaymentSubmitModel alloc]init];
    }
    return _submitModel;
}



@end
