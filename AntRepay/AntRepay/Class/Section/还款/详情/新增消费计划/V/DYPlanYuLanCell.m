//
//  DYPlanYuLanCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYPlanYuLanCell.h"

@interface DYPlanYuLanCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *midLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"planYuLanIdentifier";

@implementation DYPlanYuLanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYPlanYuLanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYPlanYuLanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.8));
    }];
}

-(void)setValueWithModel:(NSArray *)model{
    _leftLabel.text = @"2017-05-20";
    _midLabel.text = @"普通消费";
    _rightLabel.text = @"￥40.22";
}

// 还款计划列表
- (void)setValueWithHuanKuanModel:(NSArray *)model{
    _leftLabel.text = @"2017-05-20";
    _midLabel.text = @"帮你还款";
    _rightLabel.text = @"￥40.22";
}

#pragma mark - setter
- (void)setPayModel:(DYAddPayPlanpPreviewModel *)payModel {
    _payModel = payModel;
    _leftLabel.text = [payModel.time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd"];
    _midLabel.text = @"普通消费";
    _rightLabel.text = [NSString stringWithFormat:@"￥%@", payModel.money];
}

- (void)setRepayModel:(DYAddRepaymentPlanModel *)repayModel {
    _repayModel = repayModel;
    _leftLabel.text = [repayModel.time xhq_timeIntervalToStringFromatter:@"yyyy-MM-dd"];
    _midLabel.text = @"帮你还款";
    _rightLabel.text = [NSString stringWithFormat:@"￥%@", repayModel.money];
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end
