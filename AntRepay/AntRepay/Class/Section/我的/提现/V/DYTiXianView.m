//
//  DYTiXianView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTiXianView.h"

@interface DYTiXianView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *yuTitleLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UILabel *rechargeTitleLabel;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *yuanLabel;


@property (nonatomic, strong) UILabel *shenTimeLabel;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *bankNumLabel;
@property (nonatomic, strong) UILabel *userNameLabel;


@property (nonatomic, strong) UIButton *tiXianBtn;
@end

@implementation DYTiXianView

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
    _rechargeTitleLabel.text = @"提现金额";
    
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
    _textField.delegate = self;
    
    _yuanLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [_textField addSubview:_yuanLabel];
    [_yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_textField.mas_right).offset(BILIWIDTH(-10));
        make.centerY.equalTo(_textField.mas_centerY);
    }];
    _yuanLabel.text = @"元";
    
    _shenTimeLabel = [Utils labelWithTitleFontSize:13 textColor:[UIColor xhq_red] alignment:NSTextAlignmentLeft];
    _shenTimeLabel.numberOfLines = 2;
    [self addSubview:_shenTimeLabel];
    [_shenTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(_topView.mas_bottom).offset(BILIHEIGHT(17));
    }];
    _shenTimeLabel.text = @"1. 申请提现,即时到账,每笔手续费0.5元。\n2. 单次提现金额为10.5~20000；每日最高提现金额为50000";
    
    _bottomView = [[UIView alloc] init];
    [self addSubview:_bottomView];
    _bottomView.backgroundColor = KWhiteColor;
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(78)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_topView.mas_bottom).offset(BILIHEIGHT(67));
    }];
    ViewRadius(_bottomView, BILIHEIGHT(10));
    
    _imgView = [Utils imageView];
    _imgView.image = [UIImage imageNamed:@"katb"];
    [_bottomView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(36), BILIWIDTH(36)));
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_bottomView.mas_left).offset(BILIWIDTH(20));
    }];
    
    _bankNameLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_bankNameLabel];
    [_bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(20));
        make.top.equalTo(_bottomView.mas_top).offset(BILIHEIGHT(14));
    }];
    
    _userNameLabel = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bottomView.mas_right).offset(BILIWIDTH(-15));
        make.centerY.equalTo(_bankNameLabel.mas_centerY);
    }];
    
    _bankNumLabel = [Utils labelWithTitleFontSize:20 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_bankNumLabel];
    [_bankNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(BILIHEIGHT(39));
        make.left.equalTo(_bankNameLabel.mas_left);
    }];
    
    _tiXianBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(tiXianAction:) target:self title:@"提现" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_tiXianBtn];
    [_tiXianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_bottomView.mas_bottom).offset(BILIHEIGHT(39));
    }];
    ViewRadius(_tiXianBtn, BILIHEIGHT(5));
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField input:string limit:@"0123456789."];
}

#pragma mark - setter
- (void)setValueWithModel:(NSDictionary *)model{
    _bankNameLabel.text = model[@"bank_name"];
    NSString *num = model[@"bank_num"];
    NSString *headStr = [num substringToIndex:4];
    NSString *tailStr = [num substringFromIndex:16];
    
    _bankNumLabel.text = NSStringFormat(@"%@ **** **** **** %@",headStr,tailStr);
    _userNameLabel.text = model[@"realname"];
}

// 提现
- (void)tiXianAction:(UIButton *)sender{
    if (!_textField.text.length) {
        [DYShowView ShowWithText:@"请输入提现金额"];
    }else if ([_textField.text floatValue] < 0){
        [DYShowView ShowWithText:@"请输入正确的提现金额"];
    }else if ([_textField.text floatValue] < 10.5){
        [DYShowView ShowWithText:@"提现金额最少为10.5元"];
    }else if ([_textField.text floatValue] > 20000){
        [DYShowView ShowWithText:@"提现金额最大为20000元"];
    }
    else{
        if (self.tiXianBlock) {
            self.tiXianBlock(_textField.text);
        }
    }
}

@end
