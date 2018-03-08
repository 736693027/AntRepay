//
//  HomePageVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/9.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYHomePageVC.h"
#import "DYMessageVC.h"
#import "DYLoginVC.h"
#import "DYGongGaoVC.h"
#import "DYHomeWebVC.h"
#import "DYMyExtendVC.h"
#import "UIViewController+versionUpdate.h"
#import "DYGongGaoDetailVC.h"

#import <SDCycleScrollView.h>
#import "DYHomeCell.h"
#import "DYSafeVC.h"
#import "DYHomePageModel.h"
#import "DYMJRefreshViewController.h"

#define headerHeight BILIHEIGHT(205)

@interface DYHomePageVC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *headerView;
@property (nonatomic, strong) UIButton *messageBtn;

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray *noticeArray;
@property (nonatomic, assign) BOOL appleStatus;

@end

static NSString *const _image_placeholder = @"dlubj";

@implementation DYHomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.messageBtn];
}

- (void)dy_initData {
    [super dy_initData];
    self.fd_prefersNavigationBarHidden = YES;
}

-(void)dy_initUI{
    [self setTableView];
    [self.view addSubview: self.messageBtn];
    
    [self versionUpdate];
}

- (void)dy_reloadData {
    if ([NSString xhq_notEmpty:DY_APP_KEY_VALUE]) {
        [self messageReq];
    }else {
        self.messageBtn.selected = NO;
    }
}

- (void)dy_request {
    [self bannerReq];
    [self noticeReq];
}

#pragma mark - banner
- (void)bannerReq {
    XHQHUDSHOW(self.view);
    [DYAppReq GET:_url_index_banner param:nil callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        [self.tableView xhq_stopRefresh];
        if (!error) {
            [self.bannerArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *banner = responseObject[@"banner"];
                for (NSDictionary *list in banner) {
                    [self.bannerArray addObject:[DYHomePageBannerModel mj_objectWithKeyValues:list]];
                }
                [self headerViewReloadData];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 公告
- (void)noticeReq {
    [DYAppReq GET:_url_index_news param:nil callBack:^(id responseObject, NSError *error) {
        if (!error) {
            [self.noticeArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *article = responseObject[@"article"];
                for (NSDictionary *list in article) {
                    [self.noticeArray addObject:[DYHomePageNoticeModel mj_objectWithKeyValues:list]];
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - 消息
- (void)messageReq {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_mine_hp param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                NSString *message = [NSString stringWithFormat:@"%@", info[@"new_msg"]];
                [self.messageBtn setSelected:[message integerValue] > 0];
            }
        }
    }];
}

#pragma mark - 刷新轮播图
- (void)headerViewReloadData {
    NSMutableArray *mArray = @[].mutableCopy;
    for (DYHomePageBannerModel *model in self.bannerArray) {
        [mArray addObject:model.image];
    }
    self.headerView.imageURLStringsGroup = mArray;
}

#pragma mark - -
- (void)setTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = KWhiteColor;
    _tableView.tableHeaderView = self.headerView;
    
    @weakify(self);
    [_tableView xhq_refreshHeaderBlock:^{
        @strongify(self);
        [self dy_request];
    }];
    
}

- (void)setHeaderView {
    
    _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight) delegate:self placeholderImage:[UIImage imageNamed:_image_placeholder]];
    _headerView.placeholderImage = [UIImage imageNamed:_image_placeholder];
    // pagecontrol颜色
    _headerView.autoScrollTimeInterval = 5.0f;
    _headerView.currentPageDotColor = KWhiteColor;
    _headerView.pageDotColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    _headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _headerView;
}

#pragma mark - 消息点击
- (void)messageBtnClicked:(UIButton *)sender {
    if ([NSString xhq_notEmpty:DY_APP_KEY_VALUE]) {
        DYMessageVC *msg = [[DYMessageVC alloc]init];
        [self.navigationController pushViewController:msg animated:YES];
    }
    else {
        [[DYAppContext sharedDYAppContext] showLoginInViewController:self completion:nil];
    }
}

#pragma mark - 按钮点击
- (void)cellActionWithType:(HomeType)type {
    switch (type) {
        case HomeTypeAccount: //个人中心
        {
            if (![[DYAppContext sharedDYAppContext] isLogin]) {
                [[DYAppContext sharedDYAppContext] showLoginInViewController:self completion:nil];
            }
            else {
                self.tabBarController.selectedViewController = [self.tabBarController viewControllers][3];
            }
        }
            break;
        case HomeTypeExtension: //我的推广
        {
            if (![[DYAppContext sharedDYAppContext] isLogin]) {
                [[DYAppContext sharedDYAppContext] showLoginInViewController:self completion:nil];
            }
            else {
                DYMyExtendVC *extend = [[DYMyExtendVC alloc]init];
                [self.navigationController pushViewController:extend animated:YES];
            }
        }
            break;
        case HomeTypeAbout: //关于我们
        {
            DYGongGaoDetailVC *vc = [[DYGongGaoDetailVC alloc]init];
            vc.idStr = @"50";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case HomeTypeAgent: //代理加盟
        {
            DYGongGaoDetailVC *vc = [[DYGongGaoDetailVC alloc]init];
            vc.idStr = @"51";
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DYHomeCell *cell = [DYHomeCell cellWithTableView:tableView];
        cell.noticeArray = self.noticeArray;
        return cell;
    }
    DYHomeSecondCell *cell = [DYHomeSecondCell cellWithTableView:tableView];
    [cell xhq_noneSelectionStyle];
    @weakify(self);
    // 我的账户
    cell.block = ^(HomeType type) {
        @strongify(self);
        [self cellActionWithType:type];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [DYHomeCell cellHeight];
    }
    return [DYHomeSecondCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        DYGongGaoVC *vc = [[DYGongGaoVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.frame = CGRectMake(kScreenWidth - BILIWIDTH(50), kStatusBarHeight + 4, 36, 36);
        [_messageBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        [_messageBtn setImage:[UIImage imageNamed:@"news_you"] forState:UIControlStateSelected];
        [_messageBtn xhq_addTarget:self action:@selector(messageBtnClicked:)];
    }
    return _messageBtn;
}

- (SDCycleScrollView *)headerView {
    if (!_headerView) {
        _headerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight) delegate:self placeholderImage:nil];
        _headerView.autoScrollTimeInterval = 5.0f;
        _headerView.currentPageDotColor = KWhiteColor;
        _headerView.pageDotColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7];
    }
    return _headerView;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [[NSMutableArray alloc]init];
    }
    return _bannerArray;
}

- (NSMutableArray *)noticeArray {
    if (!_noticeArray) {
        _noticeArray = [NSMutableArray new];
    }
    return _noticeArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
