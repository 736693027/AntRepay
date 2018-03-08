//
//  DYRechargeView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRechargeView.h"

#define singleHeight BILIHEIGHT(44)

@interface DYRechargeView ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *yuTitleLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *rechargeTitleLabel;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *yuanLabel;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) DYAddRepaymentSingleView *kaHaoView;
@property (nonatomic, strong) DYAddRepaymentSingleView *CVN2View;
@property (nonatomic, strong) DYAddRepaymentSingleView *phoneView;
@property (nonatomic, strong) DYAddRepaymentSingleView *codeView;
@property (nonatomic, strong) UIButton *TermButton; //有效期按钮
@property (nonatomic, strong) UILabel *tipLabel;

@property (nonatomic, strong) UIButton *rechargeBtn; // 充值按钮

@end

@implementation DYRechargeView

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
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(170))];
    [self addSubview:_topView];
    _topView.backgroundColor = KWhiteColor;
    
    _yuTitleLabel = [Utils labelWithTitleFontSize:13 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_yuTitleLabel];
    [_yuTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(_topView.mas_top).offset(BILIHEIGHT(24));
    }];
    _yuTitleLabel.text = @"账户余额";
    
    _yuLabel = [Utils labelWithTitleFontSize:20 textColor:[UIColor xhq_red] alignment:NSTextAlignmentRight];
    [_topView addSubview:_yuLabel];
    [_yuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView.mas_right).offset(BILIWIDTH(-10));
        make.centerY.equalTo(_yuTitleLabel.mas_centerY);
    }];
    _yuLabel.text = @"￥0.00";
    
    _lineLabel = [UILabel xhq_lineLabel];
    [_topView addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(_topView.mas_right).offset(BILIWIDTH(-10));
        make.top.equalTo(_topView.mas_top).offset(BILIHEIGHT(60));
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
    
    _rechargeTitleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [_topView addSubview:_rechargeTitleLabel];
    [_rechargeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(_lineLabel.mas_bottom).offset(BILIHEIGHT(17));
    }];
    _rechargeTitleLabel.text = @"充值金额";
    
    _midView = [[UIView alloc] init];
    [_topView addSubview:_midView];
    [_midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(35)));
        make.top.equalTo(_rechargeTitleLabel.mas_bottom).offset(BILIHEIGHT(10));
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    ViewBorderRadius(_midView, BILIHEIGHT(5), BILIHEIGHT(1), [UIColor xhq_line]);
    
    _textField = [MyTools createTextFieldWithFont:14 placeHolder:@"0.00" placeHolderFont:14];
    [_midView addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(348), BILIHEIGHT(35)));
        make.left.equalTo(_midView.mas_left).offset(BILIHEIGHT(7));
        make.centerY.equalTo(_midView.mas_centerY);
    }];
    _textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    _yuanLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [_textField addSubview:_yuanLabel];
    [_yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_textField.mas_right).offset(BILIWIDTH(-10));
        make.centerY.equalTo(_textField.mas_centerY);
    }];
    _yuanLabel.text = @"元";
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(190), kScreenWidth, BILIHEIGHT(237))];
    [self addSubview:_bottomView];
    _bottomView.backgroundColor = KWhiteColor;
    
    _kaHaoView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, singleHeight) title:@"信用卡号" placeHolder:@"请输入信用卡卡号"];
    [_bottomView addSubview:_kaHaoView];
    _kaHaoView.xiaLaBtn.hidden = YES;
    _kaHaoView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _CVN2View = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth, singleHeight) title:@"CVN2" placeHolder:@"请输入信用卡背面三位CVN2"];
    [_bottomView addSubview:_CVN2View];
    _CVN2View.xiaLaBtn.hidden = YES;
    _CVN2View.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _youXiaoQiView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth, singleHeight) title:@"有效期" placeHolder:@"请选择信用卡有效期"];
    [_bottomView addSubview:_youXiaoQiView];
    _TermButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_TermButton xhq_addTarget:self action:@selector(TermButtonClicked)];
    [_youXiaoQiView addSubview:_TermButton];
    [_TermButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _phoneView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*3, kScreenWidth, singleHeight) title:@"手机号码" placeHolder:@"请输入银行预留手机号码"];
    [_bottomView addSubview:_phoneView];
    _phoneView.xiaLaBtn.hidden = YES;
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _codeView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*4, kScreenWidth, singleHeight) title:@"验证码" placeHolder:@"请输入验证码"];
    [_bottomView addSubview:_codeView];
    _codeView.xiaLaBtn.hidden = YES;
    _codeView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [_codeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(150), BILIHEIGHT(32)));
        make.left.equalTo(_codeView.mas_left).offset(BILIWIDTH(109));
        make.centerY.equalTo(_codeView.titleLable.mas_centerY);
    }];
    
    _codeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(codeAction:) target:self title:@"获取验证码" image:nil font:13 textColor:[UIColor xhq_green]];
    [_codeView addSubview:_codeBtn];
    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(94), BILIHEIGHT(21)));
        make.centerY.equalTo(_codeView.titleLable.mas_centerY);
        make.left.equalTo(_codeView.textField.mas_right);
    }];
    ViewBorderRadius(_codeBtn, BILIHEIGHT(10.5), BILIHEIGHT(1), [UIColor xhq_green]);
    
    _tipLabel = [UILabel xhq_layoutColor:[UIColor xhq_base]
                                    font:[UIFont xhq_font12]
                                    text:@"提示：软件需购买使用权，一次购买即可终身享用。"];
    [self addSubview:_tipLabel];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BILIWIDTH(15));
        make.top.equalTo(_bottomView.bottom).offset(BILIHEIGHT(10));
    }];
    
    _rechargeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(rechargeAction:) target:self title:@"充值" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_rechargeBtn];
    [_rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_bottomView.mas_bottom).offset(BILIHEIGHT(49));
    }];
    ViewRadius(_rechargeBtn, BILIHEIGHT(5));
}

// 获取验证码
- (void)codeAction:(UIButton *)sender{
    if (!_phoneView.textField.text.length){
        [DYShowView ShowWithText:@"请输入银行预留手机号码"];
    }else{
        if (self.codeBlock) {
            self.codeBlock(_phoneView.textField.text);
        }
    }
}

#pragma mark - 选择有效期
- (void)TermButtonClicked {
    if (self.termBlock) {
        self.termBlock();
    }
}

// 充值
- (void)rechargeAction:(UIButton *)sender{
    if (!_textField.text.length) {
        [DYShowView ShowWithText:@"请输入充值金额"];
    }else if ([_textField.text floatValue] <= 0){
        [DYShowView ShowWithText:@"请输入正确的充值金额"];
    }else if ([_textField.text floatValue] < 10){
        [DYShowView ShowWithText:@"最低充值金额为10元"];
    }else if (!_kaHaoView.textField.text.length){
        [DYShowView ShowWithText:@"请输入信用卡卡号"];
    }else if (![Utils checkCardNo:_kaHaoView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的信用卡卡号"];
    }else if (!_CVN2View.textField.text.length){
        [DYShowView ShowWithText:@"请输入CVN2"];
    }else if ([_CVN2View.textField.text length] < 3 || [_CVN2View.textField.text length] > 3){
        [DYShowView ShowWithText:@"请输入正确的信用卡背面三位CVN2"];
    }else if (!_youXiaoQiView.textField.text.length){
        [DYShowView ShowWithText:@"请选择信用卡有效期"];
    }else if (!_phoneView.textField.text.length){
        [DYShowView ShowWithText:@"请输入银行预留手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的银行预留手机号码"];
    }else if (!_codeView.textField.text.length){
        [DYShowView ShowWithText:@"请输入验证码"];
    }else{
        if (self.rechargeBlock) {
            self.rechargeBlock(_textField.text, _kaHaoView.textField.text, _CVN2View.textField.text, _youXiaoQiView.textField.text, _phoneView.textField.text, _codeView.textField.text);
        }
    }
}

@end
