//
//  DYMyExtendVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMyExtendVC.h"
#import "DYMyExtendView.h"
#import "DYExtendListVC.h"

#import "DYShareView.h"
#import <ShareSDK/ShareSDK.h>

@interface DYMyExtendVC ()

@property (nonatomic, strong) DYMyExtendUserView *userView;
@property (nonatomic, strong) DYMyExtendSalesmanView *salesmanView;

@property (nonatomic, strong) DYExtendModel *extendModel;

@end

@implementation DYMyExtendVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"我的推广";
}

- (void)dy_initUI {
    [super dy_initUI];
    
    switch (self.type) {
        case DYExtendTypeUser:
        {
            [self.view addSubview:self.userView];
        }
            break;
        case DYExtendTypeSalesman:
        {
            [self.view addSubview:self.salesmanView];
        }
            break;
        default:
            break;
    }
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_extend param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                self.extendModel = [DYExtendModel mj_objectWithKeyValues:responseObject];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        self.userView.extendModel = self.salesmanView.extendModel = self.extendModel;
    }];
}

#pragma mark - event
#pragma mark - 分享
- (void)share {
    [DYShareView shareSelectCompletion:^(DYShareType shareType) {
        SSDKPlatformType platformType;
        switch (shareType) {
            case DYShareQQ:
                platformType = SSDKPlatformTypeQQ;
                break;
            case DYShareWechat:
                platformType = SSDKPlatformSubTypeWechatSession;
                break;
            case DYShareCircle:
                platformType = SSDKPlatformSubTypeWechatTimeline;
                break;
            default:
                break;
        }
        NSString *text = @"一站式信用管理平台“蚂蚁还呗”，凭借独有的信用卡智能管理系统，能够保证用户还款的及时性和准确率，实实在在解决信用卡用户面临的一系列问题。为用户制定最优方案来管理所有信用卡，制定安全，完美账单，解放卡奴，告别逾期，有效规避银行黑名单。";
        NSString *title = @"蚂蚁还呗，推广即可赚钱";
        NSArray *imageArray = @[[UIImage imageNamed:@"ios-60"]];
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:text
                                         images:imageArray
                                            url:[NSURL URLWithString:self.extendModel.url]
                                          title:title
                                           type:SSDKContentTypeAuto];
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess: {
                    XHQHUDTEXT(@"分享成功");
                    break;
                }
                case SSDKResponseStateFail: {
                    XHQHUDTEXT(@"分享失败");
                    break;
                }
                default:
                    break;
            }
        }];
    }];
}

#pragma mark - 更多
- (void)more {
    DYExtendListVC *list = [[DYExtendListVC alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark - getter
- (DYMyExtendUserView *)userView {
    if (!_userView) {
        _userView = [[DYMyExtendUserView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationStatusHeight)];
        @weakify(self);
        _userView.shareBlock = ^{
            @strongify(self);
            [self share];
        };
        _userView.moreBlock = ^{
            @strongify(self);
            [self more];
        };
    }
    return _userView;
}

- (DYMyExtendSalesmanView *)salesmanView {
    if (!_salesmanView) {
        _salesmanView = [[DYMyExtendSalesmanView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationStatusHeight)];
        @weakify(self);
        _salesmanView.shareBlock = ^{
            @strongify(self);
            [self share];
        };
        _salesmanView.moreBlock = ^{
            @strongify(self);
            [self more];
        };
    }
    return _salesmanView;
}

- (DYExtendModel *)extendModel {
    if (!_extendModel) {
        _extendModel = [[DYExtendModel alloc]init];
    }
    return _extendModel;
}

@end
