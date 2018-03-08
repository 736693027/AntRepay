//
//  DYRepaymentDetailVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/15.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepaymentDetailVC.h"
#import "DYXiaoFeiPlanVC.h"
#import "DYHuanKuanPlanVC.h"
#import "DYRepaymentPlanPageVC.h"
#import "DYBuyUseVC.h"

#import "DYChangeAlertView.h"
#import "DYAddJiHuaView.h"
#import "DYAddXiaoFeiPlanVC.h"
#import "DYAddHuanKuanVC.h"
#import "DYChangeCardVC.h"

#import "DYRepayDetailHeaderView.h"

#define headerHeight BILIHEIGHT(224)

@interface DYRepaymentDetailVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) DYRepayDetailHeaderView *headerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, strong) DYXiaoFeiPlanVC *xiaoFeiVC;
@property (nonatomic, strong) DYHuanKuanPlanVC *huanKuanVC;
@property (nonatomic, strong) DYChangeAlertView *alertView;
@property (nonatomic, strong) DYAddJiHuaView *addAlertView;

@property (nonatomic, strong) DYRepaymentPlanPageVC *planPageVC;

@property (nonatomic, strong) DYRepaymentListModel *detailModel;

@end

@implementation DYRepaymentDetailVC

- (void)dealloc {
    [self xhq_removeAllObserveNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.title = @"信用卡详情";
    
    [self xhq_addObserveNotification:DYCardDetailInfoReloadNotification];
}

-(void)dy_initUI{
    [super dy_initUI];
    [self setHeaderView];
    [self.view addSubview:self.planPageVC.view];
    [self addChildViewController:self.planPageVC];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:kGetImage(@"more")
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(moreAction:)];
}

- (void)dy_reloadData {
    if (self.firstEnterController) {
        self.firstEnterController = NO;
        XHQHUDBGSHOW(self.view);
    }
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq GET:_url_creditCard_info param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                self.detailModel = [DYRepaymentListModel mj_objectWithKeyValues:info];
                self.headerView.detailModel = self.detailModel;
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
    
    //检测是否已经购买了使用权
    [[DYAppContext sharedDYAppContext] reloadUserInfoCompletion:nil];
}

#pragma mark - 处理通知
- (void)xhq_handleNotification:(NSNotification *)notification {
    if ([notification xhq_isNotification:DYCardDetailInfoReloadNotification]) {
        [self dy_reloadData];
    }
}

- (void)setHeaderView{
    _headerView = [[DYRepayDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, headerHeight)];
    [self.view addSubview:_headerView];
    [_headerView setValueWithModel:nil];
    @weakify(self);
    // 新增计划
    _headerView.addPlanBlock = ^{
        @strongify(self);
        DYAddHuanKuanVC *vc = [[DYAddHuanKuanVC alloc] init];
        vc.card_id = self.card_id;
        vc.repaymentDay = self.detailModel.repayment_date;
        PUSHVC(vc);
        /*
        DYAppUser *appUser = [[DYAppContext sharedDYAppContext] appUser];
        if ([appUser.is_pay integerValue] == 1) {
//            [self addShow];
//            [self aboutAddAlertView];
            
        }
        else { //未购买
            JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                        @"购买使用权后才能进行提现。\n是否要去购买使用权?",
                                        @"确定",
                                        @"取消",
                                        [self buyUsed]);
        }*/
    };
}

#pragma mark - 购买使用权
- (void)buyUsed {
    DYBuyUseVC *vc = [[DYBuyUseVC alloc]init];
    PUSHVC(vc);
}

- (void)aboutAlertView{
    @weakify(self);
    // 修改资料
    _alertView.changeZiLiaoBlock = ^{
        @strongify(self);
        DYChangeCardVC *vc = [[DYChangeCardVC alloc] init];
        vc.card_num = self.detailModel.bank_num;
        vc.card_id = self.card_id;
        PUSHVC(vc);
    };
    // 删除银行卡
    _alertView.deleteBankBlock = ^{
        @strongify(self);
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"删除银行卡会清空关于此卡的所有数据，确定要删除？",
                                    @"确定",
                                    @"取消",
                                    [self delCardReq]);
    };
    // 删除消费
    _alertView.deleteXiaoFeiBlock = ^{
        @strongify(self);
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"确定要删除消费计划吗？",
                                    @"确定",
                                    @"取消",
                                    [self delPayReq]);
    };
    // 计划解冻
    _alertView.planJieDongBlock = ^{
        @strongify(self);
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"确定要计划解冻吗？",
                                    @"确定",
                                    @"取消",
                                    [self delRepayReq]);
    };
    // 已执行计划
    _alertView.DonePlanBlock = ^{
        @strongify(self);
        DYHuanKuanPlanVC *repay = [[DYHuanKuanPlanVC alloc]init];
        repay.card_id = self.card_id;
        [self.navigationController pushViewController:repay animated:YES];
    };
}

- (void)aboutAddAlertView{
    __weak typeof(self) weakSelf = self;
    // 消费计划
    _addAlertView.xiaoFeiPlanBlock = ^{
        DYAddXiaoFeiPlanVC *vc = [[DYAddXiaoFeiPlanVC alloc] init];
        vc.card_id = weakSelf.card_id;
        WEAKPUSHVC(vc);
    };
    // 还款计划
    _addAlertView.huanKuanPlanBlock = ^{
        DYAddHuanKuanVC *vc = [[DYAddHuanKuanVC alloc] init];
        vc.card_id = weakSelf.card_id;
        vc.repaymentDay = weakSelf.detailModel.repayment_date;
        WEAKPUSHVC(vc);
    };
}

// 更多
- (void)moreAction:(UIBarButtonItem *)sender{
    [self show];
    [self aboutAlertView];
}

-(void)show{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    _alertView = [[DYChangeAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [keyWindow addSubview:_alertView];
    _alertView.imgView.frame = CGRectMake(BILIWIDTH(250), BILIHEIGHT(50), BILIWIDTH(113), 0);
    [UIView animateWithDuration:0.2 animations:^{
        _alertView.imgView.frame = CGRectMake(BILIWIDTH(250), BILIHEIGHT(50), BILIWIDTH(113), BILIHEIGHT(164));
    } completion:^(BOOL finished) {
        
    }];
}

- (void)addShow{
    _addAlertView = [[DYAddJiHuaView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _addAlertView.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, BILIHEIGHT(153));
    [[UIApplication sharedApplication].keyWindow addSubview:_addAlertView];
    [UIView animateWithDuration:0.2 animations:^{
        _addAlertView.bottomView.frame = CGRectMake(0, kScreenHeight-BILIHEIGHT(153), kScreenWidth, BILIHEIGHT(153));
    }];
}

#pragma mark - 功能操作请求

#pragma mark - 删除银行卡
- (void)delCardReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq POST:_url_creditCard_del param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [self.navigationController popViewControllerAnimated:YES];
                XHQHUDMESSAGE;
            }
            else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
    
}

#pragma mark - 删除消费
- (void)delPayReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq POST:_url_pay_del param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [self dy_reloadData];
                [self xhq_postObserveNotification:DYCardPayPlanCleanNotification];
            }
            XHQHUDMESSAGE
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 计划解冻
- (void)delRepayReq {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id
                            };
    [DYAppReq POST:_url_repay_unfreeze param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [self dy_reloadData];
                [self xhq_postObserveNotification:DYCardRepayPlanCleanNotification];
                XHQHUDMESSAGE
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - getter

- (DYRepaymentListModel *)detailModel {
    if (!_detailModel) {
        _detailModel = [[DYRepaymentListModel alloc]init];
    }
    return _detailModel;
}

- (DYRepaymentPlanPageVC *)planPageVC {
    if (!_planPageVC) {
        _planPageVC = [[DYRepaymentPlanPageVC alloc]init];
        _planPageVC.execution = YES;
        _planPageVC.card_id = self.card_id;
        _planPageVC.view.frame = CGRectMake(0, self.headerView.xhq_bottom, kScreenWidth, kScreenHeight - self.headerView.xhq_bottom);
    }
    return _planPageVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
