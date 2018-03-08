//
//  DYMonthAlertView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMonthAlertView.h"

@interface DYMonthAlertView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSString *monthStr;
@property (nonatomic, strong) NSString *monthChuanStr;
@end

@implementation DYMonthAlertView

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
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-BILIWIDTH(150), kScreenHeight/2-BILIHEIGHT(172.5), BILIWIDTH(300), BILIHEIGHT(345))];
    _alertView.backgroundColor = KWhiteColor;
    [self addSubview:_alertView];
    ViewRadius(_alertView, BILIHEIGHT(5));
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BILIWIDTH(300), BILIHEIGHT(42))];
    [_alertView addSubview:_blueView];
    _blueView.backgroundColor = [UIColor xhq_base];
    
    _titleLabel = [Utils labelWithTitleFontSize:16 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_blueView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_blueView.mas_left).offset(BILIWIDTH(16));
        make.centerY.equalTo(_blueView.mas_centerY);
    }];
    _titleLabel.text = @"设置重复逻辑";
    
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_alertView addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_alertView.mas_left).offset(BILIWIDTH(16));
        make.top.equalTo(_blueView.mas_bottom).offset(BILIHEIGHT(15));
    }];
    _label.text = @"选择每月哪几天,计划重复";
    
    CGFloat width = BILIWIDTH(29);
    CGFloat height = BILIHEIGHT(29);
    
    for (NSInteger i = 0; i < 31; i++) {
        NSInteger row = i/7;
        NSInteger col = i%7;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alertView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(width));
            
            make.height.equalTo(@(height));
            
            make.top.equalTo(_label.mas_bottom).offset((height + BILIHEIGHT(11)) * row + BILIHEIGHT(20));
            
            make.left.equalTo(_alertView.mas_left).offset((width + BILIWIDTH(10)) * col + BILIWIDTH(18));
        }];
        button.titleLabel.font = kFont(14);
        ViewBorderRadius(button, BILIWIDTH(14.5), BILIWIDTH(1), [UIColor xhq_line]);
        [button setTitle:NSStringFormat(@"%ld",i+1) forState:UIControlStateNormal];
        [button setTitleColor:[UIColor xhq_aTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor xhq_red] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 30) {
            button.tag = 10000;
        }else{
            button.tag = 10001 + i;
        }
    }
    
    _cancelBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(cancelAction:) target:self title:@"取消" image:nil font:14 textColor:KGrayColor];
    [_alertView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(55), BILIHEIGHT(45)));
        make.bottom.equalTo(_alertView.mas_bottom).offset(BILIHEIGHT(-7));
        make.right.equalTo(_alertView.mas_right).offset(BILIWIDTH(-60));
    }];
    
    _sureBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(sureAction:) target:self title:@"确定" image:nil font:14 textColor:[UIColor xhq_base]];
    [_alertView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(60), BILIHEIGHT(45)));
        make.bottom.equalTo(_alertView.mas_bottom).offset(BILIHEIGHT(-7));
        make.right.equalTo(_alertView.mas_right);
    }];
    _monthStr = @"";
    _monthChuanStr = @"";
}


- (void)buttonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        ViewBorderRadius(sender, BILIWIDTH(14.5), BILIWIDTH(0.6), [UIColor xhq_red]);
    }else{
        ViewBorderRadius(sender, BILIWIDTH(14.5), BILIWIDTH(1), [UIColor xhq_line]);
    }
}

// 取消
- (void)cancelAction:(UIButton *)sender{
    [self hide];
}

// 确定
- (void)sureAction:(UIButton *)sender{
    for (UIView *view in _alertView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button.isSelected == YES) {
                _monthChuanStr = [_monthChuanStr stringByAppendingString:NSStringFormat(@"%ld,",view.tag-10000)];
                _monthStr = [_monthStr stringByAppendingString:NSStringFormat(@"%@,",button.titleLabel.text)];
            }
        }
    }
    if (self.sureBlock) {
        if (_monthStr.length) {
            NSString *str = [_monthStr substringToIndex:_monthStr.length-1];
            NSString *chuanStr = [_monthChuanStr substringToIndex:_monthChuanStr.length-1];
            self.sureBlock(str,chuanStr);
        }
    }
    [self hide];
}


- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        _alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    } completion:^(BOOL finished) {
        [_alertView removeFromSuperview];
        _backView.backgroundColor = KClearColor;
        [self removeFromSuperview];
    }];
}

@end
