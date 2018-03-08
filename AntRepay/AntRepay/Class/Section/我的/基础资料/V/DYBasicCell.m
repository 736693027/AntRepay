//
//  DYBasicCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBasicCell.h"

static NSString *const cellIdentifier = @"basicCellIdentifier";
static NSString *const secondCellIdentifier = @"secondBasicCellIdentifier";
static NSString *const thirdCellIdentifier = @"thirdBasicCellIdentifier";

@interface DYBasicCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYBasicCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYBasicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:16 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-19));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
}

-(void)setValueWithString:(NSString *)string{
    _rightLabel.text = string;
}

/** 标题 **/
- (void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end





#pragma mark --------------------- icon cell
@interface DYBasicIconCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIImageView *nextImgView;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYBasicIconCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYBasicIconCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (!cell) {
        cell = [[DYBasicIconCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
    }
    return cell;
}

- (void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imgView = [[UIImageView alloc] init];
    _imgView.image = kGetImage(@"toux_small");
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(43), BILIWIDTH(43)));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-30));
        make.centerY.equalTo(self.mas_centerY);
    }];
    ViewRadius(_imgView, BILIWIDTH(21.5));
    _imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconAction:)];
    [_imgView addGestureRecognizer:tap];
    
    _nextImgView = [Utils imageViewWithImage:kGetImage(@"xiayib_bla")];
    [self addSubview:_nextImgView];
    [_nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(6), BILIHEIGHT(11)));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
}

-(void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

-(void)setValueWithString:(NSString *)string{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:kGetImage(@"toux_small")];
}

// 更换头像
- (void)iconAction:(UIButton *)sender{
    if (self.iconBlock) {
        self.iconBlock();
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(70);
}

@end




#pragma mark --------------------- third cell
@interface DYBasicThirdCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *nextImgView;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYBasicThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYBasicThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdCellIdentifier];
    if (!cell) {
        cell = [[DYBasicThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellIdentifier];
    }
    return cell;
}

- (void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:16 textColor:KGrayColor alignment:NSTextAlignmentRight];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-28));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _nextImgView = [Utils imageViewWithImage:kGetImage(@"xiayib_bla")];
    [self addSubview:_nextImgView];
    [_nextImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(6), BILIHEIGHT(11)));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
}

-(void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

-(void)setValueWithString:(NSString *)string{
    _rightLabel.text = string;
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end
