//
//  DYRepaymentVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/9.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepaymentVC.h"
#import "DYRepaymentCell.h"
#import "DYRepaymentHeaderView.h"
#import "DYAddRepaymentVC.h"
#import "DYRepaymentDetailVC.h"
#import "DYIdentityAuthVC.h"
#import "DYInvitationAuthenticationVC.h"

@interface DYRepaymentVC ()

@property (nonatomic, strong) DYRepaymentHeaderView *headerView;
@end

@implementation DYRepaymentVC


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
}

-(void)dy_initUI{
    [super dy_initUI];
    self.navigationItem.title = @"信用卡还款";
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.xhq_height = kScreenHeight - kNavigationStatusHeight - kTabBarHeight;
    [self.view addSubview:self.tableView];
    
    _headerView = [[DYRepaymentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(65))];
    self.tableView.tableHeaderView = _headerView;
    __weak typeof(self) weakSelf = self;
    // 添加信用卡
    _headerView.addBlock = ^{
        [weakSelf creditCard];
    };
}

- (void)dy_reloadData {
    [[DYAppCertification sharedDYAppCertification] certificationCompletion:nil];
    [self dy_refresh];
}

- (void)dy_refresh {
    [super dy_refresh];
    [self cardListReq];
}

- (void)cardListReq {
    if (self.firstEnterController) {
        self.firstEnterController = !self.firstEnterController;
        XHQHUDBGSHOW(self.view);
    }
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq POST:_url_creditCard_index param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                for (NSDictionary *list in listArray) {
                    DYRepaymentListModel *model = [DYRepaymentListModel mj_objectWithKeyValues:list];
                    [self addModelToArray:model];
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

//先判断有没有重复的 方式暴力点击测试时出现重复数据
- (void)addModelToArray:(DYRepaymentListModel *)model
{
    if (self.dataArray.count == 0)
    {
        [self.dataArray addObject:model];
        return;
    }
    for (DYRepaymentListModel *listModel in self.dataArray)
    {
        if ([model.bank_num isEqualToString:listModel.bank_num])
        {
            return;
        }
    }
    [self.dataArray addObject:model];
}

#pragma mark - 添加信用卡
- (void)creditCard {
    BOOL isIdentity = [DYAppCertification sharedDYAppCertification].isIdentity;
    BOOL isImages = [DYAppCertification sharedDYAppCertification].isImages;
    
    if (isImages && isIdentity) {
        DYAddRepaymentVC *vc = [[DYAddRepaymentVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (!isImages && !isIdentity) {
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"您还没有进行实名认证，请先完成认证在操作",
                                    @"去认证",
                                    @"取消",
                                    [self certification]);
    }
    else {
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"您的实名认证还未完成，请先完成认证在操作",
                                    @"完成认证",
                                    @"取消",
                                    [self certification]);
    }
}

#pragma mark - 实名认证
- (void)certification {
    DYIdentityAuthVC *vc = [[DYIdentityAuthVC alloc] init];
    PUSHVC(vc);
}

#pragma mark - tableViewD

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYRepaymentCell *cell = [DYRepaymentCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.dataArray.count <= indexPath.section) {
        return cell;
    }
    cell.listModel = self.dataArray[indexPath.section];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYRepaymentDetailVC *vc = [[DYRepaymentDetailVC alloc] init];
    DYRepaymentListModel *model = self.dataArray[indexPath.section];
    vc.card_id = model.ID;
    PUSHVC(vc);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYRepaymentCell cellHeight];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor xhq_section];
}

@end
