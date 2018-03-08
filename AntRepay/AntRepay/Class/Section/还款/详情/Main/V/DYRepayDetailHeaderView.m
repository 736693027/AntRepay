//
//  DYRepayDetailHeaderView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/15.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepayDetailHeaderView.h"
#import "DYRepaymentCell.h"

@interface DYRepayDetailHeaderView ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *cardImgView;
@property (nonatomic, strong) UILabel *cardNameLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) DYTopBottomView *zhangDanView;
@property (nonatomic, strong) DYTopBottomView *huanKuanView;
@property (nonatomic, strong) DYTopBottomView *moneyView;
@property (nonatomic, strong) UIImageView *lineImgView;
@property (nonatomic, strong) UIButton *jiHuanBtn; // 新增计划按钮
@property (nonatomic, strong) UIView *indicatorView;
@end

@implementation DYRepayDetailHeaderView

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
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(16));
        make.height.mas_equalTo(BILIHEIGHT(208));
    }];
    _imgView.image = kGetImage(@"bjka");
    _imgView.userInteractionEnabled = YES;
    
    _cardImgView = [Utils imageViewWithImage:kGetImage(@"katb")];
    [_imgView addSubview:_cardImgView];
    [_cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(51), BILIWIDTH(51)));
        make.left.equalTo(_imgView.mas_left).offset(BILIWIDTH(17));
        make.top.equalTo(_imgView.mas_top).offset(BILIHEIGHT(17));
    }];
    
    _cardNameLabel = [Utils labelWithTitleFontSize:14 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_imgView addSubview:_cardNameLabel];
    [_cardNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_top).offset(BILIHEIGHT(16));
        make.left.equalTo(_cardImgView.mas_right).offset(BILIWIDTH(17));
    }];
    
    _userNameLabel = [Utils labelWithTitleFontSize:13 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_imgView addSubview:_userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_top).offset(BILIHEIGHT(16));
        make.right.equalTo(_imgView.mas_right).offset(BILIWIDTH(-17));
    }];
    
    _numLabel = [Utils labelWithTitleFontSize:20 textColor:KWhiteColor alignment:NSTextAlignmentLeft];
    [_imgView addSubview:_numLabel];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_cardNameLabel.mas_bottom).offset(BILIHEIGHT(7));
        make.left.equalTo(_cardNameLabel.mas_left);
    }];
    
    _zhangDanView = [[DYTopBottomView alloc] init];
    [self addSubview:_zhangDanView];
    [_zhangDanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_top).offset(BILIHEIGHT(60));
        make.left.equalTo(_imgView.mas_left).offset(BILIWIDTH(60));
        make.height.mas_equalTo(BILIHEIGHT(72));
        make.width.mas_equalTo(BILIWIDTH(88));
    }];
    _zhangDanView.topLabel.textColor = KWhiteColor;
    _zhangDanView.bottomLabel.textColor = KWhiteColor;
    _zhangDanView.topLabel.text = @"账单日";
    
    _huanKuanView = [[DYTopBottomView alloc] init];
    [self addSubview:_huanKuanView];
    [_huanKuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_zhangDanView.mas_top);
        make.left.equalTo(_zhangDanView.mas_right);
        make.bottom.equalTo(_zhangDanView.mas_bottom);
        make.width.mas_equalTo(BILIWIDTH(82));
    }];
    _huanKuanView.topLabel.textColor = KWhiteColor;
    _huanKuanView.bottomLabel.textColor = KWhiteColor;
    _huanKuanView.topLabel.text = @"还款日";
    
    _moneyView = [[DYTopBottomView alloc] init];
    [self addSubview:_moneyView];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_zhangDanView.mas_top);
        make.right.equalTo(_imgView.mas_right);
        make.bottom.equalTo(_zhangDanView.mas_bottom);
        make.left.equalTo(_huanKuanView.mas_right);
    }];
    _moneyView.sepatorLabel.hidden = YES;
    _moneyView.topLabel.textColor = KWhiteColor;
    _moneyView.bottomLabel.textColor = KWhiteColor;
    _moneyView.topLabel.text = @"还款金额";
    
    _lineImgView = [Utils imageViewWithImage:kGetImage(@"xian")];
    [_imgView addSubview:_lineImgView];
    [_lineImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(317), BILIHEIGHT(2)));
        make.centerX.equalTo(_imgView.mas_centerX);
        make.top.equalTo(_huanKuanView.mas_bottom);
    }];
    
    _jiHuanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(jiHuaAction:) target:self title:@"新增还款计划" image:nil font:16 textColor:[UIColor xhq_green]];
    [_imgView addSubview:_jiHuanBtn];
    [_jiHuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imgView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(228), BILIHEIGHT(35)));
        make.bottom.equalTo(_imgView.mas_bottom).offset(BILIHEIGHT(-18));
    }];
    ViewBorderRadius(_jiHuanBtn, BILIHEIGHT(5), BILIWIDTH(1), [UIColor xhq_green]);
    
    _xiaoFeiBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(xiaoFeiAction:) target:self title:@"消费计划" image:nil font:14 textColor:[UIColor xhq_base]];
//    [self addSubview:_xiaoFeiBtn];
//    [_xiaoFeiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, BILIHEIGHT(46)));
//        make.bottom.equalTo(self.mas_bottom);
//    }];
    
    _huanKuanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(huanKuanAction:) target:self title:@"还款计划" image:nil font:14 textColor:[UIColor xhq_base]];
//    [self addSubview:_huanKuanBtn];
//    [_huanKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right);
//        make.size.mas_equalTo(CGSizeMake(kScreenWidth/2, BILIHEIGHT(46)));
//        make.bottom.equalTo(self.mas_bottom);
//    }];
    
    _indicatorView = [[UIView alloc] init];
//    [self addSubview:_indicatorView];
//    _indicatorView.backgroundColor = [UIColor xhq_base];
//    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(_xiaoFeiBtn.mas_centerX);
//        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-5));
//        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(35), BILIHEIGHT(2)));
//    }];
}

- (void)setValueWithModel:(NSArray *)model{
    _cardNameLabel.text = @"中国建设银行";
    _numLabel.text = @"**** **** **** **** 585";
    _userNameLabel.text = @"李健康";
    _zhangDanView.bottomLabel.text = @"10日";
    _huanKuanView.bottomLabel.text = @"4日";
    _moneyView.bottomLabel.text = @"15445.22";
}

#pragma mark - setter
- (void)setDetailModel:(DYRepaymentListModel *)detailModel {
    _detailModel = detailModel;
    _cardNameLabel.text = detailModel.bank_name;
    _numLabel.text = detailModel.bank_num;
    _userNameLabel.text = detailModel.realname;
    _zhangDanView.bottomLabel.text = [NSString stringWithFormat:@"%@日", detailModel.statement_date];
    _huanKuanView.bottomLabel.text = [NSString stringWithFormat:@"%@日", detailModel.repayment_date];
    _moneyView.bottomLabel.text = [NSString stringWithFormat:@"%@", detailModel.money];
}

// 新增计划
- (void)jiHuaAction:(UIButton *)sender{
    if (self.addPlanBlock) {
        self.addPlanBlock();
    }
}

// 消费计划
- (void)xiaoFeiAction:(UIButton *)sender{
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_xiaoFeiBtn.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-5));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(35), BILIHEIGHT(2)));
    }];
    if (self.xiaoFeiBlock) {
        self.xiaoFeiBlock();
    }
}

// 还款计划
- (void)huanKuanAction:(UIButton *)sender{
    [_indicatorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_huanKuanBtn.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-5));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(35), BILIHEIGHT(2)));
    }];
    if (self.huanKuanBlock) {
        self.huanKuanBlock();
    }
}

@end
