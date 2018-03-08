//
//  DYChangePwdVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYChangePwdVC.h"
#import "DYShiMingRenZhengView.h"
#define singleHeight BILIHEIGHT(57)

@interface DYChangePwdVC ()
@property (nonatomic, strong) DYRenZhengSingleView *oldPwdView;
@property (nonatomic, strong) DYRenZhengSingleView *freshPwdView;
@property (nonatomic, strong) DYRenZhengSingleView *reFreshPwdView;
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation DYChangePwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"修改密码";
    
    _oldPwdView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, singleHeight) title:@"原密码" placeHolder:@"请输入原密码"];
    [self.view addSubview:_oldPwdView];
    _oldPwdView.textField.secureTextEntry = YES;
    
    _freshPwdView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth, singleHeight) title:@"新密码" placeHolder:@"请输入新密码"];
    [self.view addSubview:_freshPwdView];
    _freshPwdView.textField.secureTextEntry = YES;
    
    _reFreshPwdView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth, singleHeight) title:@"确认密码" placeHolder:@"请再一次输入新密码"];
    [self.view addSubview:_reFreshPwdView];
    _reFreshPwdView.textField.secureTextEntry = YES;
    
    _saveBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(saveAction:) target:self title:@"保存" image:nil font:14 textColor:KWhiteColor];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(BILIHEIGHT(222));
    }];
    ViewRadius(_saveBtn, BILIHEIGHT(5));
}

// 保存
- (void)saveAction:(UIButton *)sender{
    if (!_oldPwdView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入原密码"];
    }else if (!_freshPwdView.textField.text.length){
        [DYShowView ShowWithText:@"请输入新密码"];
    }else if (!_reFreshPwdView.textField.text.length){
        [DYShowView ShowWithText:@"请再一次输入新密码"];
    }else if (![_freshPwdView.textField.text isEqualToString:_reFreshPwdView.textField.text]){
        [DYShowView ShowWithText:@"两次密码输入不一致,请重新输入"];
    }else{
        [self requestDataWithOldPwd:_oldPwdView.textField.text newPwd:_freshPwdView.textField.text];
    }
}

// 修改密码
- (void)requestDataWithOldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                             @"oldpass":oldPwd,
                             @"newpass":newPwd
                             };
    [DYAppReq GET:_url_change_pwd param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDTEXT(@"修改成功");
                @weakify(self);
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self);
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                XHQALERTMESSAGE
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
