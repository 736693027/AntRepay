//
//  DYRegisterView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRegisterView.h"
#import "DYLoginSingleView.h"
#define singleHeight BILIHEIGHT(68)

@interface DYRegisterView ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) DYLoginSingleView *phoneView;
@property (nonatomic, strong) DYLoginSingleView *codeView;
@property (nonatomic, strong) DYLoginSingleView *passwordView;
@property (nonatomic, strong) DYLoginSingleView *invatorView;
@property (nonatomic, strong) UIButton *registerBtn; // 注册
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *protocolBtn; // 注册协议
@end

@implementation DYRegisterView

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
    
    _imgView = [Utils imageViewWithImage:kGetImage(@"zhcebj")];
    _imgView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(BILIHEIGHT(245));
    }];
    
    
    _phoneView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(250), kScreenWidth, singleHeight) image:@"phone" placeHolder:@"请输入手机号码"];
    [self addSubview:_phoneView];
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _passwordView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(250)+singleHeight, kScreenWidth, singleHeight) image:@"mim_dl" placeHolder:@"请设置登录密码"];
    [self addSubview:_passwordView];
    _passwordView.textField.secureTextEntry = YES;
    _passwordView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    
    _codeView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(250)+singleHeight*2, kScreenWidth, singleHeight) image:@"yanzm" placeHolder:@"请输入验证码"];
    [self addSubview:_codeView];
    [_codeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.imgView.mas_right).offset(BILIWIDTH(22));
        make.centerY.equalTo(_codeView.imgView.mas_centerY);
        make.width.mas_equalTo(BILIWIDTH(197));
    }];
    _codeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _codeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(codeAction:) target:self title:@"获取验证码" image:nil font:12 textColor:[UIColor xhq_green]];
    [self addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(92), BILIHEIGHT(25)));
        make.left.equalTo(_codeView.textField.mas_right);
        make.centerY.equalTo(_codeView.textField.mas_centerY);
    }];
    ViewBorderRadius(_codeBtn, BILIHEIGHT(12.5), BILIWIDTH(1), [UIColor xhq_green]);
    
    _invatorView = [[DYLoginSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(250)+singleHeight*3, kScreenWidth, singleHeight) image:@"yaoqm" placeHolder:@"请输入注册码"];
    [self addSubview:_invatorView];
    
    _registerBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(registerAction:) target:self title:@"注 册" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_registerBtn];
    [_registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(351), BILIHEIGHT(37)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_invatorView.mas_bottom).offset(BILIHEIGHT(47));
    }];
    ViewRadius(_registerBtn, BILIWIDTH(5));
    
    _label = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_registerBtn.mas_left);
        make.top.equalTo(_registerBtn.mas_bottom).offset(BILIHEIGHT(12));
    }];
    _label.text = @"点击注册,即代表您同意";
    
    _protocolBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(protocolAction:) target:self title:@"《注册协议》" image:nil font:12 textColor:[UIColor xhq_red]];
    [self addSubview:_protocolBtn];
    [_protocolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(100), BILIHEIGHT(28)));
        make.left.equalTo(_label.mas_right);
        make.centerY.equalTo(_label.mas_centerY);
    }];
    [_protocolBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(-30), 0, 0)];
}

// 验证码
- (void)codeAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入手机号"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的手机号码"];
    }else{
        if (self.codeBlock) {
            self.codeBlock(_phoneView.textField.text);
        }
    }
}

// 注册
- (void)registerAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length){
        [DYShowView ShowWithText:@"请输入手机号"];
    }
    else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的手机号"];
    }
    else if (!_passwordView.textField.text.length){
        [DYShowView ShowWithText:@"请输入登录密码"];
    }
    else if (!_codeView.textField.text.length){
        [DYShowView ShowWithText:@"请输入短信验证码"];
    }
    else if (!_passwordView.textField.text.length){
        [DYShowView ShowWithText:@"请输入密码"];
    }
    else if (!_invatorView.textField.text.length){
        [DYShowView ShowWithText:@"请输入注册码"];
    }
    else{
        // 注册事件
        if (self.registerBlock) {
            self.registerBlock(_phoneView.textField.text, _passwordView.textField.text, _codeView.textField.text, _invatorView.textField.text);
        }
    }
}

// 注册协议
- (void)protocolAction:(UIButton *)sender{
    if (self.protocolBlock) {
        self.protocolBlock();
    }
}

@end
