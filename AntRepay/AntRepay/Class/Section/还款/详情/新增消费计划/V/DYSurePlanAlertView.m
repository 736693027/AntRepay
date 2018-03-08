//
//  DYSurePlanAlertView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSurePlanAlertView.h"

@interface DYSurePlanAlertView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@end

@implementation DYSurePlanAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_backView];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    _topView = [[UIView alloc] init];
    _topView.backgroundColor = KWhiteColor;
    [self addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(253), BILIHEIGHT(155)));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    ViewRadius(_topView, BILIHEIGHT(5));
    
    _titleLabel = [Utils labelWithTitleFontSize:18 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_topView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(BILIWIDTH(18));
        make.top.equalTo(_topView.mas_top).offset(BILIHEIGHT(18));
    }];
    _titleLabel.text = @"提示";
    
    _contentLabel = [Utils labelWithTitleFontSize:14 textColor:KDarkGrayColor alignment:NSTextAlignmentLeft];
    [_topView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView.mas_left).offset(BILIWIDTH(18));
        make.top.equalTo(_titleLabel.mas_bottom).offset(BILIHEIGHT(14));
        make.right.equalTo(_topView.mas_right).offset(BILIWIDTH(-19));
    }];
    _contentLabel.text = @"请确认计划是否正确,计划提交后不可更改";
    
    _cancelBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(cancelAction:) target:self title:@"不提交" image:nil font:14 textColor:KGrayColor];
    [_topView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(75), BILIHEIGHT(45)));
        make.bottom.equalTo(_topView.mas_bottom).offset(BILIHEIGHT(-7));
        make.right.equalTo(_topView.mas_right).offset(BILIWIDTH(-90));
    }];
    
    _sureBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(sureAction:) target:self title:@"确认提交" image:nil font:14 textColor:[UIColor xhq_base]];
    [_topView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(90), BILIHEIGHT(45)));
        make.bottom.equalTo(_topView.mas_bottom).offset(BILIHEIGHT(-7));
        make.right.equalTo(_topView.mas_right);
    }];
}

// 不提交
- (void)cancelAction:(UIButton *)sender{
    [self hide];
}

// 提交
-(void)sureAction:(UIButton *)sender{
    if (self.sureBlock) {
        self.sureBlock();
    }
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        _topView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [_topView removeFromSuperview];
        _backView.backgroundColor = KClearColor;
        [self removeFromSuperview];
    }];
}

@end
