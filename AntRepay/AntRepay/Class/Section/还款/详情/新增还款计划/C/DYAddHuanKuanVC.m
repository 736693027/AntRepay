//
//  DYAddHuanKuanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddHuanKuanVC.h"
#import "DYHuanKuanListVC.h"

#import "DYAddHuanKuanView.h"
#import "DYSelectedRepayDateView.h"

@interface DYAddHuanKuanVC ()

@property (nonatomic, strong) DYAddHuanKuanView *huanKuanView;
@property (nonatomic, strong) DYSelectedRepayDateView *dateView;

@end

@implementation DYAddHuanKuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"新增还款计划";
    _huanKuanView = [[DYAddHuanKuanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_huanKuanView];
    __weak typeof(self) weakSelf = self;
    @weakify(self);
    // 增加计划
    _huanKuanView.addPlanBlock = ^(NSString *time, NSString *money, NSString *num) {
        @strongify(self);
        NSDictionary *param = @{
                                DY_APP_KEY_VALUE_REQ,
                                @"cardid": self.card_id,
                                @"date": time,
                                @"money": money,
                                @"num": num
                                };
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"请确认还款计划是否正确,计划提交后不可更改",
                                    @"确定",
                                    @"取消",
                                    [self repaymentSubmitReq:param]);
    };
    // 查看列表
    _huanKuanView.checkPlanBlock = ^(NSString *time, NSString *money, NSString *num) {
        DYHuanKuanListVC *vc = [[DYHuanKuanListVC alloc] init];
        WEAKPUSHVC(vc);
    };
    _huanKuanView.dateBlock = ^{
        [weakSelf.dateView pop];
    };
}

#pragma mark - 还款计划提交
- (void)repaymentSubmitReq:(NSDictionary *)param {
    XHQHUDSHOW(self.view);
    [DYAppReq POST:_url_repay_add param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [self submitReqSuccess];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)submitReqSuccess {
    DYHuanKuanListVC *vc = [[DYHuanKuanListVC alloc]init];
    vc.card_id = self.card_id;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - getter
- (DYSelectedRepayDateView *)dateView {
    if (!_dateView) {
        _dateView = [[DYSelectedRepayDateView alloc]init];
        _dateView.repaymentDay = self.repaymentDay;
        @weakify(self);
        _dateView.block = ^(NSString *datesString) {
            @strongify(self);
            self.huanKuanView.timeView.textField.text = datesString;
        };
    }
    return _dateView;
}

@end
