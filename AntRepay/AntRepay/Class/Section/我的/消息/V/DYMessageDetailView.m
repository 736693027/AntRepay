//
//  DYMessageDetailView.m
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYMessageDetailView.h"

@interface DYMessageDetailView ()
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation DYMessageDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 初始化图形界面
- (void)setupUI{
    
    _myScrollView = [[UIScrollView alloc] init];
    [self addSubview:_myScrollView];
    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _myScrollView.showsVerticalScrollIndicator = NO;
    
    _bottomView = [[UIView alloc] init];
    [_myScrollView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.myScrollView);
        make.centerX.equalTo(_myScrollView.mas_centerX);
    }];
    
    _titleLable = [Utils labelWithTitleFontSize:16 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [_bottomView addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomView.mas_top).offset(BILIHEIGHT(25));
        make.left.equalTo(_bottomView.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(_bottomView.mas_right).offset(BILIWIDTH(-10));
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:14 textColor:KGrayColor alignment:NSTextAlignmentCenter];
    [_bottomView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(BILIHEIGHT(10));
        make.centerX.equalTo(_bottomView.mas_centerX);
    }];
    
    _contentLabel = [Utils labelWithTitleFontSize:14 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [_bottomView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(BILIHEIGHT(14));
        make.left.equalTo(_bottomView.mas_left).offset(BILIWIDTH(12));
        make.right.equalTo(_bottomView.mas_right).offset(BILIWIDTH(-12));
    }];
}

- (void)setTitle:(NSString *)title time:(NSString *)time content:(NSString *)content{
    _titleLable.text = title;
    NSString *newTime = [Utils timestampSwitchTime:[time integerValue] andFormatter:@"yyyy-MM-dd HH:mm"];
    _timeLabel.text = newTime;
    _contentLabel.text = content;
}

@end
