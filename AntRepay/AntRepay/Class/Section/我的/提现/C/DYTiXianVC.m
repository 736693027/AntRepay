//
//  DYTiXianVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTiXianVC.h"
#import "DYTiXianView.h"
#import "DYTiXianRecordVC.h"

@interface DYTiXianVC ()
@property (nonatomic, strong) DYTiXianView *tiXianView;
@end

@implementation DYTiXianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"提现";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提现记录" style:UIBarButtonItemStyleDone target:self action:@selector(tiRecordAction:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:kFont(14),NSForegroundColorAttributeName:[UIColor xhq_aTitle]} forState:UIControlStateNormal];
    _tiXianView = [[DYTiXianView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:_tiXianView];
    __weak typeof(self) weakSelf = self;
    // 提现
    _tiXianView.tiXianBlock = ^(NSString *money) {
        [weakSelf requestTiXianDataWithMoney:money];
    };
}

-(void)dy_request{
    [self requestTiXianMessage];
}

- (void)requestTiXianMessage{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_tiXian_message param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [_tiXianView setValueWithModel:responseObject[@"info"]];
                _tiXianView.yuLabel.text = NSStringFormat(@"￥%@",responseObject[@"info"][@"money"]);
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

// 提现申请
- (void)requestTiXianDataWithMoney:(NSString *)money{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"每笔提现定额0.5元手续费" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        XHQHUDSHOW(self.view);
        NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                                 @"money":money
                                 };
        [DYAppReq GET:_url_tiXian param:params callBack:^(id responseObject, NSError *error) {
            XHQHUDHIDE(self.view);
            if (!error) {
                if (DYAPPREQSUCCESS) {
                    XHQALERTMESSAGE
                    [self dy_request];
                }else{
                    XHQALERTMESSAGE;
                }
            }else{
                XHQHUDFAIL(self.view);
            }
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:sureAction];
    [alertVC addAction:cancelAction];
    [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    
}


/** 提现记录 **/
- (void)tiRecordAction:(UIBarButtonItem *)sender{
    DYTiXianRecordVC *vc = [[DYTiXianRecordVC alloc] init];
    PUSHVC(vc);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
