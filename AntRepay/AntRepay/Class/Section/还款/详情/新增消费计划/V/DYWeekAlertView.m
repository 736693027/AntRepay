//
//  DYWeekAlertView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYWeekAlertView.h"

@interface DYWeekAlertView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) NSString *weekStr;
@property (nonatomic, strong) NSString *weekChuanStr;
@end

@implementation DYWeekAlertView

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
    
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2-BILIWIDTH(160), kScreenHeight/2-BILIHEIGHT(122.5), BILIWIDTH(320), BILIHEIGHT(245))];
    _alertView.backgroundColor = KWhiteColor;
    [self addSubview:_alertView];
    ViewRadius(_alertView, BILIHEIGHT(5));
    
    _blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BILIWIDTH(320), BILIHEIGHT(42))];
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
    _label.text = @"选择每周哪几天,计划重复";
    
    NSArray *array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    CGFloat width = BILIWIDTH(60);
    CGFloat height = BILIHEIGHT(28);
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSInteger row = i/4;
        NSInteger col = i%4;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alertView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.equalTo(@(width));
            
            make.height.equalTo(@(height));
            
            make.top.equalTo(_label.mas_bottom).offset((height + BILIHEIGHT(14)) * row + BILIHEIGHT(20));
            
            make.left.equalTo(_alertView.mas_left).offset((width + BILIWIDTH(11)) * col + BILIWIDTH(18));
        }];
        button.titleLabel.font = kFont(14);
        ViewBorderRadius(button, BILIWIDTH(2), BILIWIDTH(1), [UIColor xhq_line]);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor xhq_aTitle] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor xhq_red] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 6) {
            button.tag = 1000;
        }else{
            button.tag = 1001 + i;
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
    _weekStr = @"";
    _weekChuanStr = @"";
}


- (void)buttonAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        ViewBorderRadius(sender, BILIWIDTH(2), BILIWIDTH(0.6), [UIColor xhq_red]);
    }else{
        ViewBorderRadius(sender, BILIWIDTH(2), BILIWIDTH(1), [UIColor xhq_line]);
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
                _weekChuanStr = [_weekChuanStr stringByAppendingString:NSStringFormat(@"%ld,",view.tag-1000)];
                _weekStr = [_weekStr stringByAppendingString:NSStringFormat(@"%@,",button.titleLabel.text)];
            }
        }
    }
    if (self.sureBlock) {
        if (_weekStr.length) {
            NSString *str = [_weekStr substringToIndex:_weekStr.length-1];
            NSString *chuanStr = [_weekChuanStr substringToIndex:_weekChuanStr.length-1];
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
