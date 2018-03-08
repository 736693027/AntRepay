//
//  DYRepayDetailPlanCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepayDetailPlanCell.h"

@interface DYRepayDetailPlanCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *midLabel;
@property (nonatomic, strong) UILabel *rightTopLabel;
@property (nonatomic, strong) UILabel *rightBottomLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *selectedButton;

@end

static NSString *const cellIdentifier = @"repaymentDetailPlanIdentifier";

@implementation DYRepayDetailPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYRepayDetailPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYRepayDetailPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _midLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_midLabel];
    [_midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(BILIWIDTH(10));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setImage:[UIImage imageNamed:@"xial_hk"] forState:UIControlStateNormal];
    _selectedButton.userInteractionEnabled = NO;
    [_selectedButton xhq_addTarget:self action:@selector(selectedButtonClicked:)];
    [self addSubview:_selectedButton];
    [_selectedButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(BILIWIDTH(0));
        make.centerY.equalTo(self);
        make.size.equalTo(CGSizeMake(BILIWIDTH(40), BILIHEIGHT(40)));
    }];
    
    _rightTopLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    _rightTopLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_rightTopLabel];
    [_rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_selectedButton.left).offset(BILIWIDTH(-5));
        make.centerY.equalTo(self.mas_centerY);
        make.left.lessThanOrEqualTo(_midLabel.right).offset(BILIWIDTH(5));
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(0));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(0));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.7));
    }];
}

#pragma mark - 关闭/展开
- (void)selectedButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.repayModel.selected = sender.selected;
    if (self.block) {
        self.block();
    }
}

#pragma mark - setter

#pragma mark - 消费计划
- (void)setConsumeModel:(DYRepaymentDetailConsumeModel *)consumeModel {
    _consumeModel = consumeModel;
    _leftLabel.text = [consumeModel.online xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm:ss"];
    _midLabel.text = @"普消";
    _rightTopLabel.text = [NSString stringWithFormat:@"￥%@", consumeModel.money];
    _rightBottomLabel.text = [self stringWithPayStatus:[consumeModel.status integerValue]];
}

- (NSString *)stringWithPayStatus:(NSInteger)status {
    switch (status) {
        case 0:
            return @"未执行";
        case 1:
            return @"处理中";
        case 2:
            return @"处理成功";
        case 3:
            return @"处理失败";
        default:
            return @"未知状态";
    }
}

#pragma mark - 还款计划

- (void)setRepayModel:(DYRepaymentDetailRepayModel *)repayModel {
    _repayModel = repayModel;
    _leftLabel.text = [repayModel.first_time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd HH:mm:ss"];
    _rightTopLabel.text = [NSString stringWithFormat:@"￥%@", repayModel.money];
    _midLabel.text = [self stringWithRepayStatus:[repayModel.status integerValue]];
    
    _selectedButton.selected = repayModel.selected;
    _selectedButton.imageView.transform = _selectedButton.selected ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformIdentity;
    
    _lineLabel.hidden = repayModel.selected;
}

- (NSString *)stringWithRepayStatus:(NSInteger)status {
    switch (status) {
        case 0:
            return @"待初次消费";
        case 11:
            return @"初次消费中";
        case 10:
            return @"初次消费失败";
        case 1:
            return @"待二次消费";
        case 21:
            return @"二次消费中";
        case 20:
            return @"二次消费失败";
        case 2:
            return @"待还款";
        case 30:
            return @"还款失败";
        case 31:
            return @"还款中";
        case 3:
            return @"已完成";
        default:
            return @"未知状态";
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end


#pragma mark - DYRepayDetailPlanShowCell 展开的cell
@interface DYRepayDetailPlanShowCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation DYRepayDetailPlanShowCell

- (void)dy_initUI {
    [super dy_initUI];
    [self xhq_noneSelectionStyle];
    self.hideSeparatorLabel = YES;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    self.hyb_lastViewInCell = self.detailLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(10);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_detailLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BILIHEIGHT(10));
        make.right.equalTo(BILIWIDTH(-15));
        make.width.lessThanOrEqualTo(BILIWIDTH(240));
    }];
    [_titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_detailLabel);
        make.left.equalTo(BILIWIDTH(15));
    }];
}

#pragma mark - setter
- (void)setInputModel:(DYRepaymentPlanInputModel *)inputModel {
    _inputModel = inputModel;
    _titleLabel.text = inputModel.title;
    if (![NSString xhq_notEmpty:inputModel.detail] ||
        [inputModel.detail isEqualToString:@"￥"]) {
        if ([inputModel.title containsString:@"初次"]) {
            _detailLabel.text = @"待初次消费";
        }else if ([inputModel.title containsString:@"二次"]) {
            _detailLabel.text = @"待二次消费";
        }else if ([inputModel.title containsString:@"还款"]) {
            _detailLabel.text = @"待还款";
        }else {
            _detailLabel.text = @"--";
        }
    }else {
        _detailLabel.text = inputModel.detail;
    }
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font14]
                                          text:@"XX"];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                           font:[UIFont xhq_font14]
                                           text:@"内容内容"];
        _detailLabel.textAlignment = 2;
        _detailLabel.numberOfLines = 0;
        _detailLabel.preferredMaxLayoutWidth = BILIWIDTH(240);
    }
    return _detailLabel;
}

@end
