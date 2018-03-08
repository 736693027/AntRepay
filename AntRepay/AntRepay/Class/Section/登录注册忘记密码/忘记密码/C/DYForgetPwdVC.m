//
//  DYForgetPwdVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYForgetPwdVC.h"
#import "DYForgetPwdView.h"

@interface DYForgetPwdVC ()
@property (nonatomic, strong) DYForgetPwdView *forgetPwdView;
@property (nonatomic, strong) NSString *codeStr;
@end

@implementation DYForgetPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNav];
}

-(void)dy_initUI{
    [super dy_initUI];
    _forgetPwdView = [[DYForgetPwdView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_forgetPwdView];
    @weakify(self);
    // 验证码
    _forgetPwdView.codeBlock = ^(NSString *phone) {
        @strongify(self);
        [self requestCodeDataWithPhone:phone];
    };
    // 保存
    _forgetPwdView.saveBlock = ^(NSString *phone, NSString *code, NSString *freshPwd, NSString *reFreshPwd) {
        @strongify(self);
        [self requestNewPwdDataWithPhone:phone pwd:freshPwd code:code];
    };
}

// 发送短信验证码
- (void)requestCodeDataWithPhone:(NSString *)phone{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"phone":phone};
    [DYAppReq GET:_url_forgetPwd_code param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [Utils getTimeWithButton:_forgetPwdView.codeBtn];
                [DYShowView ShowWithText:@"验证码已发送,请注意查收"];
                NSNumber *str = responseObject[@"info"][@"code"];
                _codeStr = NSStringFormat(@"%@",str);
                XHQ_Log(@"%@",responseObject[@"info"]);
            }else{
                XHQALERTMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

// 保存新密码
- (void)requestNewPwdDataWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code{
    if (![_codeStr isEqualToString:code]) {
        [DYShowView ShowWithText:@"您输入的验证码有误,请重新输入"];
    }else{
        XHQHUDSHOW(self.view);
        NSDictionary *params = @{@"phone":phone,@"pass":pwd};
        [DYAppReq GET:_url_forgetPwd param:params callBack:^(id responseObject, NSError *error) {
            XHQHUDHIDE(self.view);
            if (!error) {
                if (DYAPPREQSUCCESS) {
                    XHQHUDTEXT(responseObject[@"message"]);
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    XHQALERTMESSAGE;
                }
            }else{
                XHQHUDFAIL(self.view);
            }
        }];
    }
}

- (void)setNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"return") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction:)];
    self.title = @"忘记密码";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:kFont(18),NSForegroundColorAttributeName:[UIColor xhq_aTitle]}];
    
}

- (void)closeAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
