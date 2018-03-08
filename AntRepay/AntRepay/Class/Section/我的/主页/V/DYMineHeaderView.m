//
//  DYMineHeaderView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMineHeaderView.h"

@interface DYMineHeaderView ()
@property (nonatomic, strong) UIImageView *largeImgView;
@property (nonatomic, strong) UIImageView *backImgView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@end

@implementation DYMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _largeImgView = [[UIImageView alloc] init];
    [self addSubview:_largeImgView];
    [_largeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _largeImgView.image = kGetImage(@"wobj");
    _largeImgView.userInteractionEnabled = YES;
    
    _backImgView = [[UIImageView alloc] init];
    [_largeImgView addSubview:_backImgView];
    [_backImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(70), BILIWIDTH(70)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(11));
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-20));
    }];
    _backImgView.image = kGetImage(@"toux_bt");
    _backImgView.userInteractionEnabled = YES;
    
    _iconView = [[UIImageView alloc] init];
    [_backImgView addSubview:_iconView];
    [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(58), BILIWIDTH(58)));
        make.centerX.equalTo(_backImgView.mas_centerX);
        make.centerY.equalTo(_backImgView.mas_centerY);
    }];
    _iconView.image = kGetImage(@"toux_small");
    _iconView.userInteractionEnabled = YES;
    ViewRadius(_iconView, BILIWIDTH(29));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconAction:)];
    [_iconView addGestureRecognizer:tap];
    
    _userNameLabel = [Utils labelWithTitleFontSize:16 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_largeImgView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(BILIWIDTH(16));
        make.top.equalTo(_iconView.mas_top).offset(BILIHEIGHT(6));
    }];
    
    _phoneLabel = [Utils labelWithTitleFontSize:16 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_largeImgView addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconView.mas_right).offset(BILIWIDTH(16));
        make.bottom.equalTo(_iconView.mas_bottom).offset(BILIHEIGHT(-6));
    }];
}

- (void)setValueWithNickName:(NSString *)nickName phone:(NSString *)phone avatar:(NSString *)avatar{
    _userNameLabel.text = nickName;
    NSString *headStr = [phone substringToIndex:3];
    NSString *tailStr = [phone substringFromIndex:7];
    _phoneLabel.text = NSStringFormat(@"%@****%@",headStr,tailStr);
    [_iconView sd_setImageWithURL:[NSURL URLWithString:avatar] placeholderImage:kGetImage(@"toux_small")];
}

// 点击头像
- (void)iconAction:(UITapGestureRecognizer *)tap{
    if (self.iconBlock) {
        self.iconBlock();
    }
}

- (void)nextBlock:(UIButton *)sender{
    
}

@end
