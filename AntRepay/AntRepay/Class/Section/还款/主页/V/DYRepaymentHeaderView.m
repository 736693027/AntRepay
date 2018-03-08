//
//  DYRepaymentHeaderView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepaymentHeaderView.h"

@interface DYRepaymentHeaderView ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation DYRepaymentHeaderView

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
    _button = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(addAction:) target:self title:@"添加信用卡" image:@"tjia" font:16 textColor:[UIColor xhq_aTitle]];
    [_button setImageEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(-15), 0, 0)];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(180), BILIHEIGHT(40)));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

// 添加信用卡
- (void)addAction:(UIButton *)sender{
    if (self.addBlock) {
        self.addBlock();
    }
}

@end
