//
//  DYMineCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMineCell.h"

@interface DYMineCell ()
@property (nonatomic, strong) DYTitleView *availableView;
@property (nonatomic, strong) DYTitleView *unAvailableView;
@property (nonatomic, strong) UILabel *sepatorLable;
@property (nonatomic, strong) UILabel *lineLable;
@end

static NSString *const mineFirstIdentifier = @"mineFirstIdentifier";
static NSString *const mineSecondIdentifier = @"mineSecondIdentifier";
static NSString *const mineThirdIdentifier = @"mineThirdIdentifier";
static NSString *const mineBtnIdentifier = @"mineBtnIdentifier";

@implementation DYMineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMineCell *cell = [tableView dequeueReusableCellWithIdentifier:mineFirstIdentifier];
    if (!cell) {
        cell = [[DYMineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineFirstIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _availableView = [[DYTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2-BILIWIDTH(0.5), BILIHEIGHT(64))];
    [self addSubview:_availableView];
    _availableView.titleLabel.text = @"可用余额";
    
    _unAvailableView = [[DYTitleView alloc] initWithFrame:CGRectMake(kScreenWidth/2+BILIWIDTH(0.5), 0, kScreenWidth/2-BILIWIDTH(0.5), BILIHEIGHT(64))];
    [self addSubview:_unAvailableView];
    _unAvailableView.titleLabel.text = @"冻结金额";
    
    _sepatorLable = [UILabel xhq_lineLabel];
    [self addSubview:_sepatorLable];
    [_sepatorLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(1), BILIHEIGHT(37)));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLable = [UILabel xhq_lineLabel];
    [self addSubview:_lineLable];
    [_lineLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(BILIHEIGHT(1));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(64);
}

-(void)setValueWithModel:(NSDictionary *)model{
    if ([model[@"account_money"] length]) {
        _availableView.moneyLabel.text = NSStringFormat(@"￥%@",model[@"account_money"]);
    }
    if ([model[@"freeze_money"] length]) {
        _unAvailableView.moneyLabel.text = NSStringFormat(@"￥%@",model[@"freeze_money"]);
    }
}

@end



#pragma mark ---------------- 上下文字view
@implementation DYTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _titleLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(11));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _moneyLabel = [Utils labelWithTitleFontSize:18 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-8));
        make.centerX.equalTo(self.mas_centerX);
    }];
    _moneyLabel.text = @"￥0";
}

@end




#pragma mark ---------------------  充值提现
@implementation DYMineRechargeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMineRechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:mineSecondIdentifier];
    if (!cell) {
        cell = [[DYMineRechargeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineSecondIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _rechargeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_green] action:@selector(rechargeAction:) target:self title:@"充值" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_rechargeBtn];
    [_rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(133), BILIHEIGHT(30)));
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX).multipliedBy(0.5);
    }];
    ViewRadius(_rechargeBtn, BILIHEIGHT(5));
    
    _tiXianBtn =  [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(tiXianAction:) target:self title:@"提现" image:nil font:14 textColor:[UIColor xhq_green]];
    [self addSubview:_tiXianBtn];
    [_tiXianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(133), BILIHEIGHT(30)));
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX).multipliedBy(1.5);
    }];
    ViewBorderRadius(_tiXianBtn, BILIHEIGHT(5), BILIWIDTH(1), [UIColor xhq_green]);
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(61);
}

// 充值
- (void)rechargeAction:(UIButton *)sender{
    if (self.rechargeBlock) {
        self.rechargeBlock();
    }
}

// 提现
- (void)tiXianAction:(UIButton *)sender{
    if (self.tiXianBlock) {
        self.tiXianBlock();
    }
}

@end




#pragma mark --------------------- 最下方cell
@interface DYMineThirdCell ()
@property (nonatomic, strong) UIImageView *nextImgView;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYMineThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMineThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:mineThirdIdentifier];
    if (!cell) {
        cell = [[DYMineThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineThirdIdentifier];
    }
    return cell;
}

- (void)setupUI{
    
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(BILIWIDTH(20), BILIWIDTH(20)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.centerY.equalTo(self.mas_centerY);
    }];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(11));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _nextImgView = [Utils imageViewWithImage:kGetImage(@"xiayib_bla")];
    [self addSubview:_nextImgView];
    [_nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(10), BILIHEIGHT(13)));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.centerY.equalTo(self.mas_centerY);
    }];
    _contentLabel = [Utils labelWithTitleFontSize:13 textColor:[UIColor xhq_content] alignment:NSTextAlignmentLeft];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_titleLabel);
        make.right.equalTo(_nextImgView.mas_left).offset(BILIWIDTH(-10));
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
}

- (void)setTitle:(NSString *)title image:(NSString *)image{
    _titleLabel.text = title;
    _imgView.image = kGetImage(image);
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(50);
}

@end




@implementation DYMineBtnCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMineBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:mineBtnIdentifier];
    if (!cell) {
        cell = [[DYMineBtnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineBtnIdentifier];
    }
    return cell;
}

-(void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _exitBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(quitAction:) target:self title:@"安全退出" image:@"tuic" font:14 textColor:[UIColor xhq_base]];
    [self addSubview:_exitBtn];
    [_exitBtn setImageEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(-15), 0, 0)];
    [_exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(350), BILIHEIGHT(36)));
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    ViewBorderRadius(_exitBtn, BILIWIDTH(5), BILIWIDTH(0.7), [UIColor xhq_base]);
}

// 退出按钮
- (void)quitAction:(UIButton *)sender{
    if (self.exitBlock) {
        self.exitBlock();
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(83);
}

@end
