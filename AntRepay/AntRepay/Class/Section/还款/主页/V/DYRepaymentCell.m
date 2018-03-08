//
//  DYRepaymentCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYRepaymentCell.h"

static NSString *const cellIdentifier = @"repaymentIdentifier";

@interface DYRepaymentCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *cardImgView;
@property (nonatomic, strong) UILabel *cardNameLabel;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) DYTopBottomView *zhangDanView;
@property (nonatomic, strong) DYTopBottomView *huanKuanView;
@property (nonatomic, strong) DYTopBottomView *moneyView;

@end

@implementation DYRepaymentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYRepaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYRepaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = KWhiteColor;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, BILIWIDTH(10), BILIHEIGHT(13), BILIWIDTH(10)));
    }];
    ViewRadius(_backView, BILIWIDTH(8));
    
    _imgView = [[UIImageView alloc] init];
    [_backView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_backView.mas_left);
        make.right.equalTo(_backView.mas_right);
        make.top.equalTo(_backView.mas_top);
        make.height.mas_equalTo(BILIHEIGHT(86));
    }];
    _imgView.image = kGetImage(@"jianbj");
    
    _cardImgView = [Utils imageViewWithImage:kGetImage(@"katb")];
    [_imgView addSubview:_cardImgView];
    [_cardImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(51), BILIWIDTH(51)));
        make.left.equalTo(_imgView.mas_left).offset(BILIWIDTH(17));
        make.centerY.equalTo(_imgView.mas_centerY);
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
        make.bottom.equalTo(_imgView.mas_bottom).offset(BILIHEIGHT(-16));
        make.left.equalTo(_cardNameLabel.mas_left);
    }];
    
    _zhangDanView = [[DYTopBottomView alloc] init];
    [self addSubview:_zhangDanView];
    [_zhangDanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom);
        make.left.equalTo(_backView.mas_left);
        make.bottom.equalTo(_backView.mas_bottom);
        make.width.mas_equalTo((kScreenWidth-BILIWIDTH(20))/3);
    }];
    _zhangDanView.topLabel.text = @"账单日";
    
    _huanKuanView = [[DYTopBottomView alloc] init];
    [self addSubview:_huanKuanView];
    [_huanKuanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom);
        make.left.equalTo(_backView.mas_left).offset((kScreenWidth-BILIWIDTH(20))/3);
        make.bottom.equalTo(_backView.mas_bottom);
        make.width.mas_equalTo((kScreenWidth-BILIWIDTH(20))/3);
    }];
    _huanKuanView.topLabel.text = @"还款日";
    
    _moneyView = [[DYTopBottomView alloc] init];
    [self addSubview:_moneyView];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView.mas_bottom);
        make.right.equalTo(_backView.mas_right);
        make.bottom.equalTo(_backView.mas_bottom);
        make.width.mas_equalTo((kScreenWidth-BILIWIDTH(20))/3);
    }];
    _moneyView.sepatorLabel.hidden = YES;
    _moneyView.topLabel.text = @"还款金额";
}

-(void)setValueWithModel:(NSArray *)model{
    _cardNameLabel.text = @"中国建设银行";
    _numLabel.text = @"**** **** **** **** 585";
    _userNameLabel.text = @"李健康";
    _zhangDanView.bottomLabel.text = @"10日";
    _huanKuanView.bottomLabel.text = @"4日";
    _moneyView.bottomLabel.text = @"15445.22";
}

- (void)setListModel:(DYRepaymentListModel *)listModel {
    _listModel = listModel;
    _cardNameLabel.text = listModel.bank_name;
    _numLabel.text = listModel.bank_num;
    _userNameLabel.text = listModel.realname;
    _zhangDanView.bottomLabel.text = [NSString stringWithFormat:@"%@日", listModel.statement_date];
    _huanKuanView.bottomLabel.text = [NSString stringWithFormat:@"%@日", listModel.repayment_date];
    _moneyView.bottomLabel.text = [NSString stringWithFormat:@"%@", listModel.money];
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(176);
}

@end




#pragma mark ----------------- 上下文字的view
@implementation DYTopBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _topLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentCenter];
    [self addSubview:_topLabel];
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(15));
    }];
    
    _bottomLabel = [Utils labelWithTitleFontSize:17 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-17));
    }];
    
    _sepatorLabel = [UILabel xhq_lineLabel];
    [self addSubview:_sepatorLabel];
    [_sepatorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(1), BILIHEIGHT(26)));
    }];
}

@end
