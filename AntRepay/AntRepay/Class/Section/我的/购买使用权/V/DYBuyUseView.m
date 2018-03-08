//
//  DYBuyUseView.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBuyUseView.h"

@implementation DYBuyUseView



@end

#pragma mark - DYBuyUseMoneyCell  购买金额
@interface DYBuyUseMoneyCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation DYBuyUseMoneyCell
- (void)dy_initUI {
    [super dy_initUI];
    self.hideSeparatorLabel = YES;
    [self xhq_noneSelectionStyle];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.tipLabel];
    
    self.hyb_lastViewInCell = self.tipLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(30);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BILIHEIGHT(20));
        make.centerX.equalTo(self);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.bottom).offset(BILIHEIGHT(20));
        make.centerX.equalTo(self);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_priceLabel.bottom).offset(BILIHEIGHT(5));
        make.centerX.equalTo(self);
    }];
}

#pragma mark - setter
- (void)setUseModel:(DYBuyUseModel *)useModel {
    _useModel = useModel;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", useModel.use_money];
    [_priceLabel attribute:@{NSFontAttributeName: [UIFont xhq_font14]} range:NSMakeRange(0, 1)];
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font16]
                                          text:@"购买金额"];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel xhq_layoutColor:XHQHexColor(0x9ec744)
                                          font:XHQ_FONT(30)
                                          text:@"￥288.50"];
        [_priceLabel attribute:@{NSFontAttributeName: [UIFont xhq_font14]} range:NSMakeRange(0, 1)];
    }
    return _priceLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel xhq_layoutColor:[UIColor xhq_content]
                                        font:[UIFont xhq_font12]
                                        text:@"终身使用权"];
    }
    return _tipLabel;
}

@end

#pragma mark - DYBuyUseBalanceCell  账户余额
@interface DYBuyUseBalanceCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation DYBuyUseBalanceCell

- (void)dy_initUI {
    [super dy_initUI];
    self.hideSeparatorLabel = YES;
    [self xhq_noneSelectionStyle];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.tipLabel];
    self.hyb_lastViewInCell = self.tipLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(20);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(BILIHEIGHT(20));
        make.left.equalTo(BILIWIDTH(15));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(_tipLabel.left).offset(BILIWIDTH(-10));
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_priceLabel);
        make.right.equalTo(BILIWIDTH(-15));
    }];
}

#pragma mark - 充值
- (void)rechargeTap {
    if (self.block) {
        self.block();
    }
}

#pragma mark - setter
- (void)setUseModel:(DYBuyUseModel *)useModel {
    _useModel = useModel;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@", useModel.member_money];
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_content]
                                          font:[UIFont xhq_font14]
                                          text:@"账户余额"];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font16]
                                          text:@"￥0.00"];
    }
    return _priceLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel xhq_layoutColor:[UIColor redColor]
                                        font:[UIFont xhq_font12]
                                        text:@"充值"];
        [_tipLabel attribute:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}
                       range:NSMakeRange(0, _tipLabel.text.length)];
        _tipLabel.userInteractionEnabled = YES;
        [_tipLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                               action:@selector(rechargeTap)]];
    }
    return _tipLabel;
}

@end

#pragma mark - DYBuyUseTipCell 提示
@interface DYBuyUseTipCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation DYBuyUseTipCell

- (void)dy_initUI {
    [super dy_initUI];
    self.hideSeparatorLabel = YES;
    [self xhq_noneSelectionStyle];
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor xhq_section];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
    self.hyb_lastViewInCell = self.contentLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(10);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(BILIWIDTH(15));
        make.top.equalTo(BILIHEIGHT(10));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.right.equalTo(BILIWIDTH(-15));
        make.top.equalTo(_titleLabel.bottom).offset(BILIHEIGHT(10));
    }];
}

#pragma mark - setter
- (void)setUseModel:(DYBuyUseModel *)useModel {
    _useModel = useModel;
    _contentLabel.text = useModel.use_msg;
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_content]
                                          font:[UIFont xhq_font14]
                                          text:@"温馨提示："];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                            font:[UIFont xhq_font14]
                                            text:@"提示"];
        _contentLabel.numberOfLines = 0;
        _contentLabel.preferredMaxLayoutWidth = kScreenWidth - BILIWIDTH(30);
    }
    return _contentLabel;
}

@end

#pragma mark - DYbuyUseOperationView 立即购买
@implementation DYbuyUseOperationView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.operationButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
    }];
}

- (UIButton *)operationButton {
    if (!_operationButton) {
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_operationButton setBackgroundColor:[UIColor xhq_base]];
        [_operationButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_operationButton.titleLabel setFont:[UIFont xhq_font14]];
        _operationButton.layer.cornerRadius = 5.f;
        _operationButton.layer.masksToBounds = YES;
    }
    return _operationButton;
}

@end

