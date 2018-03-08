//
//  DYAddXFRepeatTypeAlertVew.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddXFRepeatTypeAlertVew.h"
#define singleHeight BILIHEIGHT(40)

@implementation DYAddXFRepeatTypeAlertVew

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
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-BILIHEIGHT(195), kScreenWidth, BILIHEIGHT(195))];
    _bottomView.backgroundColor = KClearColor;
    [self addSubview:_bottomView];
    ViewRadius(_bottomView, BILIHEIGHT(5));
    
    _topView = [[UIView alloc] init];
    [_bottomView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView.mas_centerX);
        make.top.equalTo(_bottomView.mas_top);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight*3+BILIHEIGHT(2)));
    }];
    _topView.backgroundColor = KWhiteColor;
    ViewRadius(_topView, BILIHEIGHT(5));
    
    _dayBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(dayAction:) target:self title:@"每天" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [_topView addSubview:_dayBtn];
    [_dayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_topView.mas_top);
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    
    _lineLabel1 = [UILabel xhq_lineLabel];
    [_topView addSubview:_lineLabel1];
    [_lineLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView.mas_centerX);
        make.top.equalTo(_dayBtn.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.8));
        make.width.mas_equalTo(BILIWIDTH(332));
    }];
    
    _weekBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(weekAction:) target:self title:@"每周" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [_topView addSubview:_weekBtn];
    [_weekBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_lineLabel1.mas_bottom);
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    
    _lineLabel2 = [UILabel xhq_lineLabel];
    [_topView addSubview:_lineLabel2];
    [_lineLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView.mas_centerX);
        make.top.equalTo(_weekBtn.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.8));
        make.width.mas_equalTo(BILIWIDTH(332));
    }];
    
    _monthBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(monthAction:) target:self title:@"每月" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [_topView addSubview:_monthBtn];
    [_monthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_lineLabel2.mas_bottom);
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    
    _cancelBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(cancelAction:) target:self title:@"取消" image:nil font:14 textColor:[UIColor xhq_base]];
    [_bottomView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_monthBtn.mas_bottom).offset(BILIHEIGHT(11));
        make.centerX.equalTo(_bottomView.mas_centerX);
    }];
    ViewRadius(_cancelBtn, BILIHEIGHT(5));
}

// 每天
- (void)dayAction:(UIButton *)sender{
    if (self.dayBlock) {
        self.dayBlock(@"每天");
    }
    [self hide];
}

// 每周
- (void)weekAction:(UIButton *)sender{
    if (self.weekBlock) {
        self.weekBlock(@"每周");
    }
    [self hide];
}

// 每月
- (void)monthAction:(UIButton *)sender{
    if (self.monthBlock) {
        self.monthBlock(@"每月");
    }
    [self hide];
}

- (void)cancelAction:(UIButton *)sender{
    
    [self hide];
}

- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        _bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, BILIHEIGHT(153));
    } completion:^(BOOL finished) {
        [_bottomView removeFromSuperview];
        _backView.backgroundColor = KClearColor;
        [self removeFromSuperview];
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}


@end
