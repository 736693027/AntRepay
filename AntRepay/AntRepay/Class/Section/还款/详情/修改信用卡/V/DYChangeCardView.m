//
//  DYChangeCardView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYChangeCardView.h"
#import "DYAddRepaymentView.h"
#define singleHeight BILIHEIGHT(45)

@interface DYChangeCardView () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *zhangDanBtn; // 选择账单日按钮
@property (nonatomic, strong) UIButton *huanKuanBtn; // 还款日按钮
@property (nonatomic, strong) DYAddRepaymentSingleView *cvn2View;
@property (nonatomic, strong) UIButton *changeCardBtn; // 添加信用卡按钮
@property (nonatomic, strong) UIButton *TermButton; //有效期按钮

@end

@implementation DYChangeCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _cardNumView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, singleHeight) title:@"银行卡号" placeHolder:@"请输入信用卡号"];
    [self addSubview:_cardNumView];
    _cardNumView.xiaLaBtn.hidden = YES;
    _cardNumView.textField.delegate = self;
    
    _cvn2View = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth, singleHeight) title:@"CVN2" placeHolder:@"请输入信用卡背面三位CVN2"];
    [self addSubview:_cvn2View];
    _cvn2View.xiaLaBtn.hidden = YES;
    _cvn2View.textField.keyboardType = UIKeyboardTypeNumberPad;
    
    _youXiaoQiView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth, singleHeight) title:@"有效期" placeHolder:@"请选择信用卡有效期"];
    [self addSubview:_youXiaoQiView];
    _TermButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_TermButton xhq_addTarget:self action:@selector(TermButtonClicked)];
    [_youXiaoQiView addSubview:_TermButton];
    [_TermButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _zhangDanView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*3, kScreenWidth, singleHeight) title:@"账单日" placeHolder:@"请选择账单日"];
    [self addSubview:_zhangDanView];
    _zhangDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zhangDanView addSubview:_zhangDanBtn];
    [_zhangDanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    [_zhangDanBtn addTarget:self action:@selector(zhangDanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _huanKuanView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*4, kScreenWidth, singleHeight) title:@"还款日" placeHolder:@"请选择还款日"];
    [self addSubview:_huanKuanView];
    _huanKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_huanKuanView addSubview:_huanKuanBtn];
    [_huanKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    [_huanKuanBtn addTarget:self action:@selector(huanKuanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _changeCardBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(changeCardAction:) target:self title:@"修改" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_changeCardBtn];
    [_changeCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(350), BILIHEIGHT(37)));
        make.top.equalTo(_huanKuanView.mas_bottom).offset(BILIHEIGHT(42));
        make.centerX.equalTo(self.mas_centerX);
    }];
    ViewRadius(_changeCardBtn, BILIHEIGHT(5));
}

// 账单日
- (void)zhangDanAction:(UIButton *)sender{
    [self endEditing:YES];
    if (self.zhangDanRiBlock) {
        self.zhangDanRiBlock();
    }
}

// 还款日
- (void)huanKuanAction:(UIButton *)sender{
    [self endEditing:YES];
    if (self.huanKuanRiBlock) {
        self.huanKuanRiBlock();
    }
}


#pragma mark - 选择有效期
- (void)TermButtonClicked {
    if (self.termBlock) {
        self.termBlock();
    }
}

// 修改信用卡
- (void)changeCardAction:(UIButton *)sender{
    if (!_cardNumView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入信用卡号"];
    }else if (!_cvn2View.textField.text.length){
        [DYShowView ShowWithText:@"请输入信用卡背面三位CVN2"];
    }else if (_cvn2View.textField.text.length < 3 || _cvn2View.textField.text.length > 3){
        [DYShowView ShowWithText:@"请输入正确的信用卡背面三位CVN2"];
    }else if (!_youXiaoQiView.textField.text.length){
        [DYShowView ShowWithText:@"请选择信用卡有效期"];
    }else if (!_zhangDanView.textField.text.length){
        [DYShowView ShowWithText:@"请选择账单日"];
    }else if (!_huanKuanView.textField.text.length){
        [DYShowView ShowWithText:@"请选择还款日"];
    }else{
        if (self.changeBlock) {
            self.changeBlock(_cardNumView.textField.text, _cvn2View.textField.text,_youXiaoQiView.textField.text, _zhangDanView.textField.text, _huanKuanView.textField.text);
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _cardNumView.textField) {
        return NO;
    }
    return YES;
}

@end
