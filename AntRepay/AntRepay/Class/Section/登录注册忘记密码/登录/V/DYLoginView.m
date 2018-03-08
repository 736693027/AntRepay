//
//  DYLoginView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYLoginView.h"
#import "DYLoginSingleView.h"
#define singleHeight BILIHEIGHT(68)

@interface DYLoginView ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) DYLoginSingleView *phoneView;
@property (nonatomic, strong) DYLoginSingleView *pwdView;
@end

@implementation DYLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = KWhiteColor;
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    _imgView.image = kGetImage(@"dlubj");
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(BILIHEIGHT(260));
    }];
    _imgView.userInteractionEnabled = YES;
    
    _phoneView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(265), kScreenWidth, singleHeight) image:@"phone" placeHolder:@"请输入手机号码"];
    if ([NSString xhq_notEmpty:DY_APP_USER_NAME_VALUE]) {
        _phoneView.textField.text = DY_APP_USER_NAME_VALUE;
    }
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:_phoneView];
    
    _pwdView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(265)+singleHeight, kScreenWidth, singleHeight) image:@"mim_dl" placeHolder:@"请输入登录密码"];
    [self addSubview:_pwdView];
    _pwdView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _pwdView.textField.secureTextEntry = YES;
    
    _loginBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(loginAction:) target:self title:@"登 录" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(351), BILIHEIGHT(37)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_pwdView.mas_bottom).offset(BILIHEIGHT(50));
    }];
    ViewRadius(_loginBtn, BILIWIDTH(5));
    
    
    _forgetBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(forgetAction:) target:self title:@"忘记密码?" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [self addSubview:_forgetBtn];
    [_forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(70), BILIHEIGHT(28)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(8));
        make.top.equalTo(_loginBtn.mas_bottom).offset(BILIHEIGHT(10));
    }];
    
    _registerBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(registerAction:) target:self title:@"注册" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [self addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_forgetBtn.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(40), BILIHEIGHT(28)));
    }];
}

/** 登录 **/
- (void)loginAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的手机号码"];
    }else if (!_pwdView.textField.text.length){
        [DYShowView ShowWithText:@"请输入登录密码"];
    }else{
        if (self.loginBlock) {
            self.loginBlock(_phoneView.textField.text, _pwdView.textField.text);
        }
    }
}

/** 忘记密码 **/
- (void)forgetAction:(UIButton *)sender{
    if (self.forgetPwdBlock) {
        self.forgetPwdBlock();
    }
}

/** 注册 **/
- (void)registerAction:(UIButton *)sender{
    if (self.registerBlock) {
        self.registerBlock();
    }
}

@end
