//
//  DYLoginVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYLoginVC.h"
#import "DYLoginView.h"
#import "DYRegisterVC.h"
#import "DYForgetPwdVC.h"

@interface DYLoginVC ()
@property (nonatomic, strong) DYLoginView *loginView;
@end

@implementation DYLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNav];
}

-(void)dy_initUI{
    [super dy_initUI];
    _loginView = [[DYLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_loginView];
    @weakify(self);
    // 登录
    _loginView.loginBlock = ^(NSString *phone, NSString *pwd) {
        @strongify(self);
        [self requestLoginDataWithPhone:phone pwd:pwd];
    };
    // 注册
    _loginView.registerBlock = ^{
        @strongify(self);
        DYRegisterVC *vc = [[DYRegisterVC alloc] init];
        PUSHVC(vc);
    };
    // 忘记密码
    _loginView.forgetPwdBlock = ^{
        @strongify(self);
        DYForgetPwdVC *vc = [[DYForgetPwdVC alloc] init];
        PUSHVC(vc);
    };
}

// 请求用户登录数据
-(void)requestLoginDataWithPhone:(NSString *)phone pwd:(NSString *)pwd{
    XHQHUDSHOW(self.view); //加载圈
    NSDictionary *param = @{@"phone": phone,
                            @"pass": pwd};
    [DYAppReq POST:_url_login param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view); //隐藏
        if (!error) {
            if (DYAPPREQSUCCESS) { //成功判断
                XHQHUDTEXT(@"登录成功");
                [self saveUserName:phone pass:pwd];
                NSDictionary *info = responseObject[@"info"];
                [[DYAppContext sharedDYAppContext] loginSuccess:info];
                //doing
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }else {
                XHQHUDMESSAGE //错误提示
//                JWALERT_NO_ACTION_SHOW(@"提示",
//                                       responseObject[@"message"]);
            }
        }else {
            XHQHUDFAIL(self.view); //网络错误提示
        }
    }];
}

- (void)saveUserName:(NSString *)phone pass:(NSString *)pass {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:phone forKey:DY_APP_USER_NAME];
    [ud setObject:pass forKey:DY_APP_USER_PASS];
    [ud synchronize];
}

- (void)setNav{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"guan_dl") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction:)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-BILIWIDTH(100), 44)];
    UILabel *label = [Utils labelWithTitleFontSize:18 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
    }];
    label.text = @"登录";
    self.navigationItem.titleView = view;
    // 必须设置为yes 否则不透明(???)
    self.navigationController.navigationBar.translucent = YES;
    // 加上之后才起作用
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:KWhiteColor}];
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)closeAction:(UIBarButtonItem *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
