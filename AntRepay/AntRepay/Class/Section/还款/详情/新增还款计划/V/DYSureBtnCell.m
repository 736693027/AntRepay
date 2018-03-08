//
//  DYSureBtnCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSureBtnCell.h"
#import "DYAddRepaymentPlanModel.h"

static NSString *const cellIdentifier = @"sureCellIdentifier";

@implementation DYSureBtnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSureBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYSureBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _sureBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(sureAction:) target:self title:@"提交计划" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    ViewRadius(_sureBtn, BILIHEIGHT(5));
}

// 确定
- (void)sureAction:(UIButton *)sender{
    if (self.sureBlock) {
        self.sureBlock();
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(100);
}

@end


@interface DYPlanPreviewCell ()

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) UILabel *repayLabel;

@end

@implementation DYPlanPreviewCell

- (void)dy_initUI{
    [super dy_initUI];
    
    [self xhq_noneSelectionStyle];
    
    [self addSubview:self.totalLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.firstLabel];
    [self addSubview:self.secondLabel];
    [self addSubview:self.feeLabel];
    [self addSubview:self.repayLabel];
    
    self.hyb_lastViewInCell = self.repayLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(15);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_totalLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BILIWIDTH(12.5));
        make.top.equalTo(BILIHEIGHT(15));
        make.right.lessThanOrEqualTo(self.centerX).offset(BILIWIDTH(-5));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_totalLabel);
        make.left.equalTo(self.centerX);
        make.right.lessThanOrEqualTo(BILIWIDTH(-10));
    }];
    [_firstLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalLabel);
        make.top.equalTo(_totalLabel.bottom).offset(BILIHEIGHT(10));
        make.right.lessThanOrEqualTo(self.centerX).offset(BILIWIDTH(-5));
    }];
    [_secondLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstLabel);
        make.left.equalTo(_timeLabel);
        make.right.lessThanOrEqualTo(BILIWIDTH(-10));
    }];
    [_feeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_totalLabel);
        make.top.equalTo(_firstLabel.bottom).offset(BILIHEIGHT(10));
        make.right.lessThanOrEqualTo(self.centerX).offset(BILIWIDTH(-5));
    }];
    [_repayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_feeLabel);
        make.left.equalTo(_timeLabel);
        make.right.lessThanOrEqualTo(BILIWIDTH(-10));
    }];
}

#pragma mark - setter
- (void)setPlanModel:(DYAddRepaymentPlanModel *)planModel {
    _planModel = planModel;
    _totalLabel.text = [NSString stringWithFormat:@"计划总额：￥%@", planModel.money];
    _timeLabel.text = [NSString stringWithFormat:@"计划时间：%@", [planModel.plan_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd"]];
    _firstLabel.text = [NSString stringWithFormat:@"初次消费：￥%@", planModel.first_money];
    _secondLabel.text = [NSString stringWithFormat:@"二次消费：￥%@", planModel.second_money];
    _feeLabel.text = [NSString stringWithFormat:@"手续费用：￥%@", planModel.fee_money];
    _repayLabel.text = [NSString stringWithFormat:@"还款总额：￥%@", planModel.repayment_money];
}

#pragma mark - getter
- (UILabel *)totalLabel {
    if (!_totalLabel) {
        _totalLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font14]
                                          text:@"计划总额"];
        _totalLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _totalLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font14]
                                          text:@"计划时间"];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _timeLabel;
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                         font:[UIFont xhq_font14]
                                         text:@"初次消费"];
        _firstLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font14]
                                          text:@"二次消费"];
        _secondLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _secondLabel;
}

- (UILabel *)feeLabel {
    if (!_feeLabel) {
        _feeLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                           font:[UIFont xhq_font14]
                                           text:@"手续费用"];
        _feeLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _feeLabel;
}

- (UILabel *)repayLabel {
    if (!_repayLabel) {
        _repayLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                        font:[UIFont xhq_font14]
                                        text:@"还款总额"];
        _repayLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _repayLabel;
}

@end
