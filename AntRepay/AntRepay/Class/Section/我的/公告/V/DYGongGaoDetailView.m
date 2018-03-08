//
//  DYGongGaoDetailView.m
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYGongGaoDetailView.h"

@interface DYGongGaoDetailView ()

@property (nonatomic, strong) UIView *bottomView;
@end

@implementation DYGongGaoDetailView

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
    
//    _myScrollView = [[UIScrollView alloc] init];
//    [self addSubview:_myScrollView];
//    [_myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    _myScrollView.showsVerticalScrollIndicator = NO;
//
//    _bottomView = [[UIView alloc] init];
//    [_myScrollView addSubview:_bottomView];
//    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.myScrollView);
//        make.centerX.equalTo(_myScrollView.mas_centerX);
//    }];
    
    _titleLable = [Utils labelWithTitleFontSize:16 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(18));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:14 textColor:KGrayColor alignment:0];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLable.mas_bottom).offset(BILIHEIGHT(5));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
    }];
    
    _webView = [[UIWebView alloc] init];
    _webView.backgroundColor = KWhiteColor;
    [self addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(BILIHEIGHT(5));
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)setTitle:(NSString *)title time:(NSString *)time{
    _titleLable.text = title;
    NSString *newTime = [Utils timestampSwitchTime:[time integerValue] andFormatter:@"yyyy-MM-dd HH:mm"];
    _timeLabel.text = newTime;
}

@end
