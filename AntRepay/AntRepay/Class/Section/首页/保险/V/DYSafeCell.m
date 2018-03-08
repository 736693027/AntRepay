//
//  DYSafeCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSafeCell.h"

static NSString *const cellIdentifier = @"safeCellIdentifier";
static NSString *const detailCellIdentifier = @"safeDetailCellIdentifier";
static NSString *const detailBottomCellIdentifier = @"safeDetailBottomCellIdentifier";

@interface DYSafeCell ()
@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIImageView *rightImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation DYSafeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSafeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYSafeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _leftImgView = [[UIImageView alloc] init];
    [self addSubview:_leftImgView];
    [_leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(18));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(136), BILIHEIGHT(66)));
    }];
    _leftImgView.image = kGetImage(@"timsdsg");
    
    _rightImgView = [[UIImageView alloc] init];
    [self addSubview:_rightImgView];
    [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImgView.mas_right);
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(18));
        make.height.mas_equalTo(BILIHEIGHT(66));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
    }];
    _rightImgView.image = kGetImage(@"beij_bx");
    
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [_rightImgView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightImgView.mas_left).offset(BILIWIDTH(14));
        make.top.equalTo(_rightImgView.mas_top).offset(BILIHEIGHT(10));
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [_rightImgView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_rightImgView.mas_left).offset(BILIWIDTH(14));
        make.bottom.equalTo(_rightImgView.mas_bottom).offset(BILIHEIGHT(-10));
    }];
}

-(void)setValueWithModel:(NSArray *)model{
    _titleLabel.text = @"个人支付账户安全险";
    _timeLabel.text = @"保障期限 2017-08-25~2018-08-25";
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(85);
}

@end




#pragma mark ---------------- 详情cell
@interface DYSafeDetailCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYSafeDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSafeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellIdentifier];
    if (!cell) {
        cell = [[DYSafeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.height.mas_equalTo(BILIHEIGHT(0.8));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)setValueWithTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (void)setValueWithContent:(NSString *)content{
    if (content) {
        _rightLabel.text = content;
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(43);
}

@end




#pragma mark ---------------- 详情底部cell
@interface DYSafeDetailBottomCell ()
@property (nonatomic, strong) UIButton *tiaoKuanBtn;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation DYSafeDetailBottomCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSafeDetailBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:detailBottomCellIdentifier];
    if (!cell) {
        cell = [[DYSafeDetailBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailBottomCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _tiaoKuanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(tiaoKuanAction:) target:self title:@"《保险条款》" image:nil font:14 textColor:[UIColor xhq_base]];
    [self addSubview:_tiaoKuanBtn];
    [_tiaoKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(91), BILIHEIGHT(38)));
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
    }];
    
    _phoneLabel = [Utils labelWithTitleFontSize:20 textColor:[UIColor xhq_green] alignment:NSTextAlignmentLeft];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(44));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _bottomLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_bottomLabel];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-18));
        make.centerX.equalTo(self.mas_centerX);
    }];
    _bottomLabel.text = @"服务热线";
}

-(void)setValueWithPhone:(NSString *)phone{
    _phoneLabel.text = @"40066-95535";
}

// 保险条款
- (void)tiaoKuanAction:(UIButton *)sender{
    if (self.tiaoKuanBlock) {
        self.tiaoKuanBlock();
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(105);
}

@end
