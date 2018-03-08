//
//  DYShiMingRenZhengView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYShiMingRenZhengView.h"
#define titleHeight BILIHEIGHT(40)
#define singleHeight BILIHEIGHT(47)

@interface DYShiMingRenZhengView ()
@property (nonatomic, strong) DYShiMingTitleView *firstTitleView;
@property (nonatomic, strong) DYRenZhengSingleView *zhangHuView;
@property (nonatomic, strong) DYRenZhengSingleView *codeView;
@property (nonatomic, strong) DYRenZhengSingleView *nameView;
@property (nonatomic, strong) DYRenZhengSingleView *idCardView;
@property (nonatomic, strong) DYRenZhengSingleView *addressView;
@property (nonatomic, strong) DYShiMingTitleView *secondTitleView;
@property (nonatomic, strong) DYRenZhengSingleView *bankNumView;
@property (nonatomic, strong) DYRenZhengSingleView *zhiHangView;
@property (nonatomic, strong) DYRenZhengSingleView *phoneView;

@property (nonatomic, strong) UILabel *shuoMingLabel; // 说明文字
@property (nonatomic, strong) UIButton *submitBtn;  // 提交按钮
@property (nonatomic, strong) UIButton *issuingBankButton; //发卡银行
@property (nonatomic, strong) UIButton *provinceButton;
@property (nonatomic, strong) UIButton *cityButton;

@end

@implementation DYShiMingRenZhengView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _firstTitleView = [[DYShiMingTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, titleHeight) title:@"个人信息"];
    [self addSubview:_firstTitleView];
    
    _zhangHuView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight, kScreenWidth, singleHeight) title:@"账户" placeHolder:@"账户名"];
    [self addSubview:_zhangHuView];
    _zhangHuView.textField.text = DY_APP_USER_NAME_VALUE;
    _zhangHuView.textField.userInteractionEnabled = NO;
    
    _codeView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight, kScreenWidth, singleHeight) title:@"验证码" placeHolder:@"请输入验证码"];
    [self addSubview:_codeView];
    [_codeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.mas_left).offset(BILIWIDTH(109));
        make.width.mas_equalTo(BILIWIDTH(150));
        make.centerY.equalTo(_codeView.titleLable.mas_centerY);
        make.height.mas_equalTo(BILIHEIGHT(32));
    }];
    
    _codeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(codeAction:) target:self title:@"获取验证码" image:nil font:14 textColor:[UIColor xhq_green]];
    [_codeView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(94), BILIHEIGHT(27)));
        make.left.equalTo(_codeView.textField.mas_right);
        make.centerY.equalTo(_codeView.textField.mas_centerY);
    }];
    _codeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    ViewBorderRadius(_codeBtn, BILIHEIGHT(13.5), BILIWIDTH(1), [UIColor xhq_green]);
    
    _nameView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight*2, kScreenWidth, singleHeight) title:@"真实姓名" placeHolder:@"请输入真实姓名"];
    [self addSubview:_nameView];
    
    _idCardView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight*3, kScreenWidth, singleHeight) title:@"身份证号" placeHolder:@"请输入身份证号"];
    [self addSubview:_idCardView];
    
    _shengView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight*4, kScreenWidth, singleHeight) title:@"户籍所在省" placeHolder:@"请选择输入户籍所在省份"];
    _shengView.xiaLaBtn.hidden = NO;
    [self addSubview:_shengView];
    _provinceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_provinceButton xhq_addTarget:self action:@selector(provinceButtonClicked)];
    [_shengView addSubview:_provinceButton];
    [_provinceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _shiView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight*5, kScreenWidth, singleHeight) title:@"户籍所在市" placeHolder:@"请选择户籍所在市"];
    _shiView.xiaLaBtn.hidden = NO;
    [self addSubview:_shiView];
    _cityButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cityButton xhq_addTarget:self action:@selector(cityButtonClicked)];
    [_shiView addSubview:_cityButton];
    [_cityButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _addressView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight + singleHeight*6, kScreenWidth, singleHeight) title:@"身份证地址" placeHolder:@"请输入身份证地址"];
    [self addSubview:_addressView];
    _addressView.lineLabel.hidden = YES;
    
    _secondTitleView = [[DYShiMingTitleView alloc] initWithFrame:CGRectMake(0, titleHeight+singleHeight*7, kScreenWidth, titleHeight) title:@"银行卡信息"];
    [self addSubview:_secondTitleView];
    
    _bankNumView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight*2+singleHeight*7, kScreenWidth, singleHeight) title:@"信用卡号" placeHolder:@"请输入信用卡号码"];
    [self addSubview:_bankNumView];
    _bankNumView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _bankNameView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight*2 + singleHeight*8, kScreenWidth, singleHeight) title:@"发卡银行" placeHolder:@"请选择发卡银行"];
    _bankNameView.xiaLaBtn.hidden = NO;
    [self addSubview:_bankNameView];
    _issuingBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_issuingBankButton xhq_addTarget:self action:@selector(issuingBankButtonClicked)];
    [_bankNameView addSubview:_issuingBankButton];
    [_issuingBankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
//    _zhiHangView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight*2 + singleHeight*9, kScreenWidth, singleHeight) title:@"银行联行号" placeHolder:@"请输入银行联行号"];
//    [self addSubview:_zhiHangView];
    
    
    
    _phoneView = [[DYRenZhengSingleView alloc] initWithFrame:CGRectMake(0, titleHeight*2 + singleHeight*9, kScreenWidth, singleHeight) title:@"预留手机号码" placeHolder:@"请输入银行预留手机号码"];
    [self addSubview:_phoneView];
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    _phoneView.lineLabel.hidden = YES;
    
    _shuoMingLabel = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_red] alignment:NSTextAlignmentLeft];
    [self addSubview:_shuoMingLabel];
    [_shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.top.equalTo(_phoneView.mas_bottom).offset(BILIHEIGHT(20));
    }];
    _shuoMingLabel.text = @"注: 上传的银行卡只能为信用卡，绑定后不可随意修改。";
    
    // UIButton frame 超出父视图范围时虽然会显示,单点击事件无法响应
    _submitBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(tiJiaoAction:) target:self title:@"提交" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_submitBtn];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_shuoMingLabel.mas_bottom).offset(BILIHEIGHT(20));
    }];
    ViewRadius(_submitBtn, BILIHEIGHT(5));
}

// 验证码
- (void)codeAction:(UIButton *)sender{
    if(self.codeBlock) {
        self.codeBlock(_zhangHuView.textField.text);
    }
}

#pragma mark - 发卡银行
- (void)issuingBankButtonClicked {
    [self endEditing:YES];
    if (self.issuingBlock) {
        self.issuingBlock();
    }
}

#pragma mark - 省份
- (void)provinceButtonClicked {
    [self endEditing:YES];
    if (self.provinceBlock) {
        self.provinceBlock();
    }
}

#pragma mark - 城市
- (void)cityButtonClicked {
    [self endEditing:YES];
    if (self.cityBlock) {
        self.cityBlock();
    }
}

// 提交
- (void)tiJiaoAction:(UIButton *)sender{
    if (!_codeView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入验证码"];
    }else if (!_nameView.textField.text.length){
        [DYShowView ShowWithText:@"请输入真实姓名"];
    }else if (!_idCardView.textField.text.length){
        [DYShowView ShowWithText:@"请输入身份证号"];
    }else if (![Utils validateIdentityCard:_idCardView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的身份证号"];
    }else if (!_shengView.textField.text.length){
        [DYShowView ShowWithText:@"请选择户籍所在省份"];
    }else if (!_shiView.textField.text.length){
        [DYShowView ShowWithText:@"请选择户籍所在市"];
    }else if (!_addressView.textField.text.length){
        [DYShowView ShowWithText:@"请输入身份证地址"];
    }else if (!_bankNumView.textField.text.length){
        [DYShowView ShowWithText:@"请输入储蓄卡号码"];
    }else if (!_bankNameView.textField.text.length){
        [DYShowView ShowWithText:@"请选择发卡银行"];
    }else if (!_phoneView.textField.text.length){
        [DYShowView ShowWithText:@"请输入银行预留手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]) {
        [DYShowView ShowWithText:@"请输入正确的手机号码"];
    }else{
        if (self.submitBlock) {
            self.submitBlock(_nameView.textField.text, _idCardView.textField.text, _addressView.textField.text, _bankNumView.textField.text, _bankNameView.textField.text, _zhiHangView.textField.text, _shengView.textField.text, _shiView.textField.text, _phoneView.textField.text, _codeView.textField.text);
        }
    }
}

@end




#pragma mark ----------------------  文字 view
@implementation DYShiMingTitleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title{
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.centerY.equalTo(self.mas_centerY);
    }];
    _label.text = title;
}

@end



#pragma mark ---------------- 认证 singleView
@implementation DYRenZhengSingleView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title placeHolder:placeHolder];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
    self.backgroundColor = KWhiteColor;
    _titleLable = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(14));
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-10));
    }];
    _titleLable.text = title;
    
    _textField = [MyTools createTextFieldWithFont:14 placeHolder:placeHolder placeHolderFont:14];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(109));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.centerY.equalTo(_titleLable.mas_centerY);
        make.height.mas_equalTo(BILIHEIGHT(32));
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIHEIGHT(-10));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
    
    _xiaLaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _xiaLaBtn.hidden = YES;
    [_xiaLaBtn setImage:kGetImage(@"xial_hk") forState:UIControlStateNormal];
    [self addSubview:_xiaLaBtn];
    [_xiaLaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(53), BILIHEIGHT(35)));
        make.right.equalTo(self.mas_right);
    }];
}

@end

#pragma mark - DYAntRealnameView 蚂蚁还呗实名
@interface DYAntRealnameView ()

@property (nonatomic, strong) DYRenZhengSingleView *zhangHuView;
@property (nonatomic, strong) DYRenZhengSingleView *codeView;
@property (nonatomic, strong) DYRenZhengSingleView *realname;
@property (nonatomic, strong) DYRenZhengSingleView *idCard;
@property (nonatomic, strong) UIButton *submitButton;

@end

@implementation DYAntRealnameView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.zhangHuView];
    [self addSubview:self.codeView];
    [self.codeView addSubview:self.codeButton];
    [self addSubview:self.realname];
    [self addSubview:self.idCard];
    [self addSubview:self.submitButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_zhangHuView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BILIHEIGHT(10));
        make.left.right.equalTo(0);
        make.height.equalTo(BILIHEIGHT(47));
    }];
    [_codeView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_zhangHuView);
        make.top.equalTo(_zhangHuView.bottom).offset(BILIHEIGHT(0));
    }];
    [_codeView.textField remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView.mas_left).offset(BILIWIDTH(109));
        make.width.mas_equalTo(BILIWIDTH(150));
        make.centerY.equalTo(_codeView.titleLable.mas_centerY);
        make.height.mas_equalTo(BILIHEIGHT(32));
    }];
    [_codeButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(94), BILIHEIGHT(27)));
        make.left.equalTo(_codeView.textField.mas_right);
        make.centerY.equalTo(_codeView.textField.mas_centerY);
    }];
    [_realname makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_zhangHuView);
        make.top.equalTo(_codeView.bottom).offset(BILIHEIGHT(0));
    }];
    [_idCard makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(_zhangHuView);
        make.top.equalTo(_realname.bottom).offset(BILIHEIGHT(0));
    }];
    [_submitButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(0);
        make.top.equalTo(_idCard.bottom).offset(BILIHEIGHT(30));
        make.size.equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
    }];
}

#pragma mark - 提交
- (void)submitButtonClicked {
    if (![NSString xhq_cnNameFormatCheck:_realname.textField.text tip:@"真实姓名"]) {
        return;
    }
    if (![NSString xhq_idFormatCheck:_idCard.textField.text tip:@"身份证号"]) {
        return;
    }
    if (![NSString xhq_notEmpty:_codeView.textField.text tip:@"验证码"]) {
        return;
    }
    [self endEditing:YES];
    if (self.block) {
        self.block(_realname.textField.text, _idCard.textField.text, _codeView.textField.text);
    }
}

#pragma mark - 获取验证码
- (void)codeButtonClicked {
    if (self.codeBlock) {
        self.codeBlock(_zhangHuView.textField.text);
    }
}

#pragma mark - getter
- (DYRenZhengSingleView *)zhangHuView {
    if (!_zhangHuView) {
        _zhangHuView = [[DYRenZhengSingleView alloc]initWithFrame:CGRectZero
                                                            title:@"账号"
                                                      placeHolder:@""];
        _zhangHuView.textField.text = DY_APP_USER_NAME_VALUE;
        _zhangHuView.textField.userInteractionEnabled = NO;
    }
    return _zhangHuView;
}

- (DYRenZhengSingleView *)codeView {
    if (!_codeView) {
        _codeView = [[DYRenZhengSingleView alloc]initWithFrame:CGRectZero
                                                         title:@"验证码"
                                                   placeHolder:@"请输入验证码"];
        
    }
    return _codeView;
}

- (DYRenZhengSingleView *)realname {
    if (!_realname) {
        _realname = [[DYRenZhengSingleView alloc]initWithFrame:CGRectZero
                                                         title:@"真实姓名"
                                                   placeHolder:@"请输入您的真实姓名"];
    }
    return _realname;
}

- (DYRenZhengSingleView *)idCard {
    if (!_idCard) {
        _idCard = [[DYRenZhengSingleView alloc]initWithFrame:CGRectZero
                                                       title:@"身份证号"
                                                 placeHolder:@"请输入您的身份证号,'X'请大写"];
    }
    return _idCard;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton xhq_buttonFrame:CGRectZero
                                          bgColor:[UIColor xhq_base]
                                       titleColor:[UIColor whiteColor]
                                      borderWidth:0
                                      borderColor:nil
                                     cornerRadius:BILIHEIGHT(5)
                                              tag:0
                                           target:self
                                           action:@selector(submitButtonClicked)
                                            title:@"提交"];
        _submitButton.xhqFont = [UIFont xhq_font14];
    }
    return _submitButton;
}

- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor clearColor]
                                     titleColor:[UIColor xhq_green]
                                    borderWidth:1
                                    borderColor:[UIColor xhq_green].CGColor
                                   cornerRadius:BILIHEIGHT(13.5)
                                            tag:0
                                         target:self
                                         action:@selector(codeButtonClicked)
                                          title:@"获取验证码"];
        _codeButton.xhqFont = [UIFont xhq_font14];
    }
    return _codeButton;
}

@end
