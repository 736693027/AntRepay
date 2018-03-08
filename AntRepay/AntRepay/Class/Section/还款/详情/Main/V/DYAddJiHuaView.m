//
//  DYAddJiHuaView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddJiHuaView.h"
#define singleHeight BILIHEIGHT(40)

@implementation DYAddJiHuaView

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
    
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-BILIHEIGHT(153), kScreenWidth, BILIHEIGHT(153))];
    _bottomView.backgroundColor = KClearColor;
    [self addSubview:_bottomView];
    ViewRadius(_bottomView, BILIHEIGHT(5));
    
    _topView = [[UIView alloc] init];
    [_bottomView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bottomView.mas_centerX);
        make.top.equalTo(_bottomView.mas_top);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight*2+BILIHEIGHT(1)));
    }];
    _topView.backgroundColor = KWhiteColor;
    ViewRadius(_topView, BILIHEIGHT(5));
    
    _xiaoFeiBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(xiaoFeiAction:) target:self title:@"消费计划" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [_topView addSubview:_xiaoFeiBtn];
    [_xiaoFeiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_topView.mas_top);
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [_topView addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_topView.mas_centerX);
        make.top.equalTo(_xiaoFeiBtn.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.8));
        make.width.mas_equalTo(BILIWIDTH(332));
    }];
    
    _huanKuanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(huanKuanAction:) target:self title:@"还款计划" image:nil font:14 textColor:[UIColor xhq_aTitle]];
    [_topView addSubview:_huanKuanBtn];
    [_huanKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_lineLabel.mas_bottom);
        make.centerX.equalTo(_topView.mas_centerX);
    }];
    
    _cancelBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(cancelAction:) target:self title:@"取消" image:nil font:14 textColor:[UIColor xhq_base]];
    [_bottomView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), singleHeight));
        make.top.equalTo(_huanKuanBtn.mas_bottom).offset(BILIHEIGHT(11));
        make.centerX.equalTo(_bottomView.mas_centerX);
    }];
    ViewRadius(_cancelBtn, BILIHEIGHT(5));
}

// 消费计划
- (void)xiaoFeiAction:(UIButton *)sender{
    if (self.xiaoFeiPlanBlock) {
        self.xiaoFeiPlanBlock();
    }
    [self hide];
}

// 还款计划
- (void)huanKuanAction:(UIButton *)sender{
    if (self.huanKuanPlanBlock) {
        self.huanKuanPlanBlock();
    }
    [self hide];
}

// 取消
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
