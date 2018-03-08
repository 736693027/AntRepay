//
//  DYForgetPwdView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYForgetPwdView.h"
#import "DYForgetPwdSingleView.h"
#define singleHeight BILIHEIGHT(56)

@interface DYForgetPwdView ()
@property (nonatomic, strong) DYForgetPwdSingleView *phoneView;
@property (nonatomic, strong) DYForgetPwdSingleView *codeView;
@property (nonatomic, strong) DYForgetPwdSingleView *freshPwdView;
@property (nonatomic, strong) DYForgetPwdSingleView *rePwdView;
@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation DYForgetPwdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _phoneView = [[DYForgetPwdSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, singleHeight) title:@"手机号码" placeHolder:@"请输入手机号码"];
    [self addSubview:_phoneView];
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _codeView = [[DYForgetPwdSingleView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth, singleHeight) title:@"验证码" placeHolder:@"请输入验证码"];
    [self addSubview:_codeView];
    
    [_codeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.mas_left).offset(BILIWIDTH(106));
        make.centerY.equalTo(_codeView.titleLabel.mas_centerY);
        make.width.mas_equalTo(BILIWIDTH(150));
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
    
    _freshPwdView = [[DYForgetPwdSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth, singleHeight) title:@"新密码" placeHolder:@"请输入新密码"];
    [self addSubview:_freshPwdView];
    _freshPwdView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _freshPwdView.textField.secureTextEntry = YES;
    
    _rePwdView = [[DYForgetPwdSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*3, kScreenWidth, singleHeight) title:@"确认密码" placeHolder:@"请再一次输入新密码"];
    [self addSubview:_rePwdView];
    _rePwdView.textField.keyboardType = UIKeyboardTypeASCIICapable;
    _rePwdView.textField.secureTextEntry = YES;
    
    _saveBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(saveAction:) target:self title:@"保 存" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(351), BILIHEIGHT(37)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_rePwdView.mas_bottom).offset(BILIHEIGHT(47));
    }];
    ViewRadius(_saveBtn, BILIWIDTH(5));
}

// 验证码
- (void)codeAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的手机号码"];
    }else{
        if (self.codeBlock) {
            self.codeBlock(_phoneView.textField.text);
        }
    }
}

// 保存
- (void)saveAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的手机号码"];
    }else if (!_codeView.textField.text.length){
        [DYShowView ShowWithText:@"请输入验证码"];
    }else if (!_freshPwdView.textField.text.length){
        [DYShowView ShowWithText:@"请输入新密码"];
    }else if (!_rePwdView.textField.text.length){
        [DYShowView ShowWithText:@"请再一次输入新密码"];
    }else if (![_freshPwdView.textField.text isEqualToString:_rePwdView.textField.text
                ]){
        [DYShowView ShowWithText:@"两次密码输入不一致,请重新输入"];
    }else{
        if (self.saveBlock) {
            self.saveBlock(_phoneView.textField.text, _codeView.textField.text, _freshPwdView.textField.text, _rePwdView.textField.text);
        }
    }
}

@end
