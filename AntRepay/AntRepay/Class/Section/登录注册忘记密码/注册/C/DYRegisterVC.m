//
//  DYRegisterVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRegisterVC.h"
#import "DYRegisterView.h"
#import "DYProtocolVC.h"

@interface DYRegisterVC ()
@property (nonatomic, strong) DYRegisterView *registerView;
@property (nonatomic, strong) NSString *codeStr;
@end

@implementation DYRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNav];
}

-(void)dy_initUI{
    [super dy_initUI];
    _registerView = [[DYRegisterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:_registerView];
    @weakify(self);
    // 验证码
    _registerView.codeBlock = ^(NSString *phone) {
        @strongify(self);
        [self requestCodeDataWithPhone:phone];
    };
    // 注册
    _registerView.registerBlock = ^(NSString *phone, NSString *password, NSString *codeNumber, NSString *inviterPhone) {
        @strongify(self);
        [self requestRegisterDataWithPhone:phone pwd:password code:codeNumber jiHuoMa:inviterPhone];
    };
    // 注册协议
    _registerView.protocolBlock = ^{
        @strongify(self);
        DYProtocolVC *vc = [[DYProtocolVC alloc] init];
        PUSHVC(vc);
    };
}

// 发送短信验证码
- (void)requestCodeDataWithPhone:(NSString *)phone{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"phone":phone};
    [DYAppReq GET:_url_register_code param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [Utils getTimeWithButton:_registerView.codeBtn];
                [DYShowView ShowWithText:@"验证码已发送,请注意查收"];
                NSNumber *str = responseObject[@"info"][@"code"];
                _codeStr = NSStringFormat(@"%@",str);
                XHQ_Log(@"%@",responseObject[@"info"]);
            }else {
                XHQALERTMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

// 用户注册
- (void)requestRegisterDataWithPhone:(NSString *)phone pwd:(NSString *)pwd code:(NSString *)code jiHuoMa:(NSString *)jiHuoMa{
    if (![_codeStr isEqualToString:code]) {
        [DYShowView ShowWithText:@"您输入的验证码有误,请重新输入"];
    }else{
        XHQHUDSHOW(self.view);
        NSDictionary *params = @{@"phone":phone,@"pass":pwd,@"code":jiHuoMa};
        [DYAppReq GET:_url_register param:params callBack:^(id responseObject, NSError *error) {
            XHQHUDHIDE(self.view);
            if (!error) {
                if (DYAPPREQSUCCESS) {
                    XHQHUDTEXT(@"注册成功");
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"guanb_zhc") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction:)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-BILIWIDTH(100), 44)];
    UILabel *label = [Utils labelWithTitleFontSize:18 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
    }];
    label.text = @"注册";
    self.navigationItem.titleView = view;
    // 必须设置为yes 否则不透明(???)
    self.navigationController.navigationBar.translucent = YES;
    // 加上之后才起作用
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //去掉导航栏底部的黑线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:KWhiteColor}];
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)closeAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //在页面消失的时候就让navigationbar还原样式
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor xhq_aTitle]}];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
