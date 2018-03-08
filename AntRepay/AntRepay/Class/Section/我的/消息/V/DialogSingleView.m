
//
//  dialogSingleView.m
//  WeiMinJinFu
//
//  Created by 崔祥莉 on 2017/8/15.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DialogSingleView.h"

@implementation DialogSingleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//初始化图形界面
- (void)setupUI{
    // 小黄圆点点
    _yellowView = [[UIView alloc] init];
    [self addSubview:_yellowView];
    _yellowView.backgroundColor = [UIColor xhq_base];
    _yellowView.layer.cornerRadius = 3;
    _yellowView.layer.masksToBounds = YES;
    [_yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(16));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.width.mas_equalTo(BILIWIDTH(6));
        make.height.mas_equalTo(BILIHEIGHT(6));
    }];
    
    // 标题
    _titleLabel = [[UILabel alloc] init];
    [self addSubview:_titleLabel];
    _titleLabel.font = kFont(14);
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yellowView.mas_right).offset(BILIWIDTH(5));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(5));
        make.width.mas_equalTo(BILIWIDTH(100));
    }];
    _titleLabel.numberOfLines = 0;
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.textColor = [UIColor xhq_aTitle];
    
    // 时间
    _timeLabel = [[UILabel alloc] init];
    [self addSubview:_timeLabel];
    _timeLabel.font = kFont(12);
    _timeLabel.textColor = KGrayColor;
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-8));
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.height.mas_equalTo(BILIHEIGHT(17));
    }];
    
    // 内容
    _contentLable = [[UILabel alloc] init];
    [self addSubview:_contentLable];
    _contentLable.font = kFont(13);
    _contentLable.textColor = KGrayColor;
    [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(BILIHEIGHT(5));
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-10));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
    }];
    
    //底部分割线
    _lineView = [[UIView alloc] init];
    [self addSubview:_lineView];
    _lineView.backgroundColor = [UIColor xhq_line];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(BILIHEIGHT(1));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
