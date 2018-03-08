//
//  DYExtendListView.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYExtendListView.h"

@implementation DYExtendListView



@end

#pragma mark - DYExtendListSectonView 推广记录标题
@interface DYExtendListSectonView ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation DYExtendListSectonView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor xhq_section];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(0);
        make.width.equalTo(BILIWIDTH(120));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(_phoneLabel.right).offset(BILIWIDTH(5));
        make.width.equalTo(BILIWIDTH(85));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(0);
        make.left.equalTo(_nameLabel.right).offset(BILIWIDTH(5));
    }];
}

#pragma mark - getter
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:XHQ_FONTBOLD(BILIWIDTH(14))
                                          text:@"手机号"];
        _phoneLabel.textAlignment = 1;
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                         font:XHQ_FONTBOLD(BILIWIDTH(14))
                                         text:@"姓名"];
        _nameLabel.textAlignment = 1;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                         font:XHQ_FONTBOLD(BILIWIDTH(14))
                                         text:@"注册时间"];
        _timeLabel.textAlignment = 1;
    }
    return _timeLabel;
}

@end


#pragma mark - DYExtendListCell 推广记录列表
@interface DYExtendListCell ()

@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation DYExtendListCell

- (void)dy_initUI {
    [super dy_initUI];
    [self xhq_noneSelectionStyle];
    self.hideSeparatorLabel = YES;
    
    [self addSubview:self.phoneLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(0);
        make.width.equalTo(BILIWIDTH(120));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(0);
        make.left.equalTo(_phoneLabel.right).offset(BILIWIDTH(5));
        make.width.equalTo(BILIWIDTH(85));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.equalTo(0);
        make.left.equalTo(_nameLabel.right).offset(BILIWIDTH(5));
    }];
}

#pragma mark - setter
- (void)setListModel:(DYExtendListModel *)listModel {
    _phoneLabel.text = listModel.phone;
    if ([NSString xhq_notEmpty:listModel.realname]) {
        _nameLabel.text = listModel.realname;
    }
    else {
        _nameLabel.text = @"未实名";
    }
    _timeLabel.text = [listModel.add_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm"];
}

#pragma mark - getter
- (UILabel *)phoneLabel {
    if (!_phoneLabel) {
        _phoneLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:XHQ_FONT(BILIWIDTH(14))
                                          text:@"188****8888"];
        _phoneLabel.textAlignment = 1;
    }
    return _phoneLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                         font:XHQ_FONT(BILIWIDTH(14))
                                         text:@"未实名"];
        _nameLabel.textAlignment = 1;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                         font:XHQ_FONT(BILIWIDTH(14))
                                         text:@"2017-12-22 15:01"];
        _timeLabel.textAlignment = 1;
    }
    return _timeLabel;
}

@end
