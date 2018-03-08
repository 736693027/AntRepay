//
//  DYAccountVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/9.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAccountVC.h"
#import "DYRechargeVC.h"
#import "DYTiXianVC.h"
#import "DYBasicDataVC.h"
#import "DYSettingVC.h"
#import "DYShiMingVC.h"
#import "DYChangePwdVC.h"
#import "DYMessageVC.h"
#import "DYGongGaoVC.h"
#import "DYIdentityAuthVC.h"
#import "DYInvitationAuthenticationVC.h"
#import "DYMineZhangDanVC.h"
#import "DYLoginVC.h"
#import "DYMyExtendVC.h"
#import "DYBuyUseVC.h"
#import "DYBankVC.h"

#import "DYMineHeaderView.h"
#import "DYMineCell.h"
#import "DYNavgationView.h"

#define HeaderHeight BILIHEIGHT(170)

@interface DYAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DYMineHeaderView *headerView;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) DYNavgationView *dy_navigationView;

@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSDictionary *minehpDic; // 用户资金情况

@end

@implementation DYAccountVC

-(NSDictionary *)minehpDic{
    if (!_minehpDic) {
        _minehpDic = [NSDictionary dictionary];
    }
    return _minehpDic;
}

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
        _titleArr = @[
                      @{@"img":@"tixian_wo",@"title":@"提现"},
                      @{@"img":@"zhangd",@"title":@"我的账单"},
                      @{@"img":@"xiugmm_wo",@"title":@"修改密码"},
                      @{@"img":@"shiming_wo",@"title":@"实名认证"},
                      @{@"img":@"jibenzl_wo",@"title":@"基本资料"},
                      @{@"img":@"bank_wo",@"title":@"绑定银行卡"},
                      @{@"img":@"tuiguang_wo",@"title":@"我的推广"},
//                      @{@"img":@"goumai_wo",@"title":@"购买使用权"},
                      @{@"img":@"gonggtz_wo",@"title":@"公告通知"},
                      @{@"img":@"zhuyi_wo",@"title":@"注意事项"},
                      @{@"img":@"shez_wo",@"title":@"设置"}
                      ];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.messageBtn];
}

- (void)dy_reloadData {
    
    [self requestNewMessageData];
    
    [[DYAppCertification sharedDYAppCertification] certificationCompletion:^(BOOL isIdentity, BOOL isImages) {
        [self.tableView reloadData];
        [self.tableView xhq_stopRefresh];
    }];
    
    [[DYAppContext sharedDYAppContext] reloadUserInfoCompletion:^{
        [self.tableView xhq_stopRefresh];
        DYAppUser *appUser = [DYAppContext sharedDYAppContext].appUser;
        [_headerView setValueWithNickName:appUser.nickname
                                    phone:appUser.phone
                                   avatar:appUser.avatar];
    }];
}

- (void)dy_initData {
    [super dy_initData];
    self.fd_prefersNavigationBarHidden = YES;
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.xhq_height = kScreenHeight - kTabBarHeight;
    self.tableView.tableHeaderView = self.headerView;
    [self.view addSubview:self.dy_navigationView];
    [self.view addSubview:self.messageBtn];
}

- (void)dy_refresh {
    [super dy_refresh];
    [self dy_reloadData];
}

// 请求是否有新消息
- (void)requestNewMessageData{
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_mine_hp param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.minehpDic = info;
                NSString *message = [NSString stringWithFormat:@"%@", info[@"new_msg"]];
                [self.messageBtn setSelected:[message integerValue] > 0];
                [self.tableView reloadData];
            }
        }
    }];
}

#pragma mark - 实名验证判断
- (void)requestShiMingData{
    BOOL isIdentity = [DYAppCertification sharedDYAppCertification].isIdentity;
    BOOL isImages = [DYAppCertification sharedDYAppCertification].isImages;
    
    if (!isIdentity || !isImages) {
        [self certification];
    }
    else {
        XHQHUDTEXT(@"您已实名认证");
    }
}

#pragma mark - 实名认证
- (void)certification {
    DYIdentityAuthVC *vc = [[DYIdentityAuthVC alloc] init];
    PUSHVC(vc);
}

#pragma mark - 绑定储蓄卡
- (void)bankCardBind {
    BOOL isIdentity = [DYAppCertification sharedDYAppCertification].isIdentity;
    BOOL isImages = [DYAppCertification sharedDYAppCertification].isImages;
    if (isImages && isIdentity) {
        DYBankVC *vc = [[DYBankVC alloc]init];
        PUSHVC(vc);
    }else if (!isImages && !isIdentity) {
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

#pragma mark - 购买使用权
- (void)buyUsed {
    DYBuyUseVC *vc = [[DYBuyUseVC alloc]init];
    PUSHVC(vc);
}

#pragma mark - 充值提现
- (void)chongZhiTiXian:(BOOL)isTX {
    
    BOOL isIdentity = [DYAppCertification sharedDYAppCertification].isIdentity;
    BOOL isImages = [DYAppCertification sharedDYAppCertification].isImages;
    
    if (isImages && isIdentity) { //实名认证
        if (isTX) {
            /*
            DYAppUser *appUser = [DYAppContext sharedDYAppContext].appUser;
            if ([appUser.is_pay integerValue] != 1) { //使用权验证
                JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                            @"购买使用权后才能进行提现。\n是否要去购买使用权?",
                                            @"确定",
                                            @"取消",
                                            [self buyUsed]);
                return;
            }*/
                if ([self.minehpDic[@"cash_bank"] integerValue] != 1) { //储蓄卡验证
                    JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                                @"绑定银行卡后才能进行提现。\n是否要去绑定银行卡?",
                                                @"确定",
                                                @"取消",
                                                [self bankCardBind]);
                    return;
                }
                DYTiXianVC *vc = [[DYTiXianVC alloc] init];
                PUSHVC(vc);
        }
        else {
            DYRechargeVC *vc = [[DYRechargeVC alloc] init];
            PUSHVC(vc);
        }
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

#pragma mark - 消息点击
- (void)messageAction:(UIBarButtonItem *)sender {
    DYMessageVC *vc = [[DYMessageVC alloc] init];
    PUSHVC(vc);
}

#pragma mark - tableViewD
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 6;
    }else if (section == 2) {
        return 1;
    }
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                DYMineCell *cell = [DYMineCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (self.minehpDic) {
                    [cell setValueWithModel:self.minehpDic];
                }
                return cell;
            }else if (indexPath.row == 1){
                DYMineRechargeCell *cell = [DYMineRechargeCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                // 充值
                @weakify(self);
                cell.rechargeBlock = ^{
                    @strongify(self);
                    [self chongZhiTiXian:NO];
                };
                // 提现
                cell.tiXianBlock = ^{
                    @strongify(self);
                    [self chongZhiTiXian:YES];
                };
                return cell;
            }
        }
            break;
        case 1:{
            DYMineThirdCell *cell = [DYMineThirdCell cellWithTableView:tableView];
            [cell setTitle:self.titleArr[indexPath.row][@"title"] image:self.titleArr[indexPath.row][@"img"]];
            if (indexPath.row == 3) {
                BOOL isIdentity = [DYAppCertification sharedDYAppCertification].isIdentity;
                BOOL isImages = [DYAppCertification sharedDYAppCertification].isImages;
                if (isIdentity && isImages) {
                    cell.contentLabel.text = @"已认证";
                }
                else if (isIdentity && !isImages) {
                    cell.contentLabel.text = @"上传图片";
                }
                else if (!isIdentity && isImages) {
                    cell.contentLabel.text = @"实名认证";
                }
                else {
                    cell.contentLabel.text = @"未认证";
                }
            }
            else if (indexPath.row == 5) {
                cell.contentLabel.text = [self.minehpDic[@"cash_bank"] integerValue] == 1 ? @"已绑定" : @"未绑定";
            }
            else {
                cell.contentLabel.text = @"";
            }
            return cell;
        }
            break;
        case 2: {
            DYMineThirdCell *cell = [DYMineThirdCell cellWithTableView:tableView];
            [cell setTitle:self.titleArr[indexPath.row+6][@"title"] image:self.titleArr[indexPath.row+6][@"img"]];
            if (indexPath.row == 1) {
                DYAppUser *appUser = [DYAppContext sharedDYAppContext].appUser;
                cell.contentLabel.text = [appUser.is_pay integerValue] == 1 ? @"已购买" : @"未购买";
            }
            else {
                cell.contentLabel.text = @"";
            }
            return cell;
        }
            break;
        case 3:{
            if (indexPath.row == 3) {
                DYMineBtnCell *cell = [DYMineBtnCell cellWithTableView:tableView];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                @weakify(self);
                // 安全退出
                cell.exitBlock = ^{
                    @strongify(self);
                    [self exitAction];
                };
                return cell;
            }else{
                DYMineThirdCell *cell = [DYMineThirdCell cellWithTableView:tableView];
                [cell setTitle:self.titleArr[indexPath.row+7][@"title"] image:self.titleArr[indexPath.row+7][@"img"]];
                return cell;
            }
        }
            break;
            
        default:
            break;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 1) {
            DYMineZhangDanVC *vc = [[DYMineZhangDanVC alloc] init];
            PUSHVC(vc);
        }else if (indexPath.row == 2){
            DYChangePwdVC *vc = [[DYChangePwdVC alloc] init];
            PUSHVC(vc);
        }else if (indexPath.row == 3){
            [self requestShiMingData];
        }else if (indexPath.row == 4){
            DYBasicDataVC *vc = [[DYBasicDataVC alloc] init];
            PUSHVC(vc);
        }else if (indexPath.row == 0) {
            [self chongZhiTiXian:YES];
        }else if (indexPath.row == 5) {
            [self bankCardBind];
        }
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            DYGongGaoVC *vc = [[DYGongGaoVC alloc] init];
            PUSHVC(vc);
        }else if (indexPath.row == 1) {
            DYGongGaoVC *vc = [[DYGongGaoVC alloc] init];
            vc.careful = YES;
            PUSHVC(vc);
        }else if (indexPath.row == 2) {
            DYSettingVC *vc = [[DYSettingVC alloc] init];
            PUSHVC(vc);
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            DYMyExtendVC *vc = [[DYMyExtendVC alloc]init];
            DYAppUser *appUser = [DYAppContext sharedDYAppContext].appUser;
            if ([appUser.is_worker integerValue] == 1) {
                vc.type = DYExtendTypeSalesman;
            }
            else {
                vc.type = DYExtendTypeUser;
            }
            PUSHVC(vc);
        }else {
            DYAppUser *appUser = [DYAppContext sharedDYAppContext].appUser;
            if ([appUser.is_pay integerValue] != 1) {
                [self buyUsed];
            }
            else {
                XHQHUDTEXT(@"您已购买过使用权");
            }
        }
    }
}

/** 退出登录 **/
- (void)exitAction{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出当前账户吗?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:0 handler:^(UIAlertAction * _Nonnull action) {
        [[DYAppContext sharedDYAppContext] setIsLogin:NO];
        [[DYAppContext sharedDYAppContext] showLoginInViewController:self completion:^{
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
            [self.tableView setContentOffset:CGPointMake(0, 0)];
        }];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:sureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return [DYMineCell cellHeight];
        }else if (indexPath.row == 1){
            return [DYMineRechargeCell cellHeight];
        }
    }else if (indexPath.section == 1 || indexPath.section == 2){
        return [DYMineThirdCell cellHeight];
    }else if (indexPath.section == 3){
        if (indexPath.row == 3) {
            return [DYMineBtnCell cellHeight];
        }
        return [DYMineThirdCell cellHeight];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(12))];
        return view;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2 || section == 3) {
        return BILIHEIGHT(12);
    }
    return 0;
}

#pragma mark - getter
- (DYMineHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[DYMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HeaderHeight)];
        @weakify(self);
        _headerView.iconBlock = ^{
            @strongify(self);
            DYBasicDataVC *vc = [[DYBasicDataVC alloc] init];
            PUSHVC(vc);
        };
    }
    return _headerView;
}

- (DYNavgationView *)dy_navigationView {
    if (!_dy_navigationView) {
        _dy_navigationView = [[DYNavgationView alloc]init];
        _dy_navigationView.superScrollView = self.tableView;
        _dy_navigationView.superButton = self.messageBtn;
//        [_dy_navigationView.messageButton xhq_addTarget:self action:@selector(messageAction:)]
    }
    return _dy_navigationView;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageBtn.frame = CGRectMake(kScreenWidth - 50, kStatusBarHeight + 3, 36, 36);
        [_messageBtn setImage:[UIImage imageNamed:@"news"] forState:UIControlStateNormal];
        [_messageBtn setImage:[UIImage imageNamed:@"news_you"] forState:UIControlStateSelected];
        [_messageBtn xhq_addTarget:self action:@selector(messageAction:)];
        _messageBtn.layer.cornerRadius = 18;
        _messageBtn.layer.masksToBounds = YES;
    }
    return _messageBtn;
}



@end
