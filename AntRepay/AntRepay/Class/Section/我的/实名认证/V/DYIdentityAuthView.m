//
//  DYIdentityAuthView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYIdentityAuthView.h"
#import "DYShiMingRenZhengView.h"
#define singleHeight BILIHEIGHT(153)

@interface DYIdentityAuthView ()
@property (nonatomic, strong) DYShiMingTitleView *titleView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) DYIdentityAuthSingleView *firstView;
@property (nonatomic, strong) DYIdentityAuthSingleView *secondView;
@property (nonatomic, strong) DYIdentityAuthSingleView *thirdView;
@property (nonatomic, strong) DYIdentityAuthSingleView *forthView;
@property (nonatomic, strong) DYIdentityAuthSingleView *fifthView;
@property (nonatomic, strong) DYIdentityAuthSingleView *sixView;

@property (nonatomic, strong) UILabel *shuoMingLabel; // 说明文字
@end

@implementation DYIdentityAuthView

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
    _titleView = [[DYShiMingTitleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(40)) title:@"上传证件照片"];
    [self addSubview:_titleView];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(40), kScreenWidth, BILIHEIGHT(470))];
    [self addSubview:_topView];
    _topView.backgroundColor = KWhiteColor;
    
    _firstView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth/2, singleHeight) title:@"身份证证件 ( 正面 )"];
    [_topView addSubview:_firstView];
    [_firstView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.left.equalTo(_firstView.mas_left).offset(BILIWIDTH(20));
        make.top.equalTo(_firstView.mas_top).offset(BILIHEIGHT(15));
    }];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstAction:)];
    [_firstView addGestureRecognizer:tap1];
    
    _secondView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, singleHeight) title:@"身份证证件 ( 反面 )"];
    [_topView addSubview:_secondView];
    [_secondView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.top.equalTo(_secondView.mas_top).offset(BILIHEIGHT(15));
        make.left.equalTo(_secondView.mas_left).offset(BILIWIDTH(10));
    }];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondAction:)];
    [_secondView addGestureRecognizer:tap2];
    
    _thirdView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth/2, singleHeight) title:@"手持身份证照片"];
    [_topView addSubview:_thirdView];
    [_thirdView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.left.equalTo(_thirdView.mas_left).offset(BILIWIDTH(20));
        make.top.equalTo(_thirdView.mas_top).offset(BILIHEIGHT(15));
    }];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdAction:)];
    [_thirdView addGestureRecognizer:tap3];
    
    _forthView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(kScreenWidth/2, singleHeight, kScreenWidth/2, singleHeight) title:@"信用卡照片 ( 正面 )"];
    [_topView addSubview:_forthView];
    [_forthView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.top.equalTo(_forthView.mas_top).offset(BILIHEIGHT(15));
        make.left.equalTo(_forthView.mas_left).offset(BILIWIDTH(10));
    }];
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(forthAction:)];
    [_forthView addGestureRecognizer:tap4];
    
    _fifthView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth/2, singleHeight) title:@"信用卡照片 ( 反面 )"];
    [_topView addSubview:_fifthView];
    [_fifthView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.left.equalTo(_fifthView.mas_left).offset(BILIWIDTH(20));
        make.top.equalTo(_fifthView.mas_top).offset(BILIHEIGHT(15));
    }];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fifthAction:)];
    [_fifthView addGestureRecognizer:tap5];
    
    _sixView = [[DYIdentityAuthSingleView alloc] initWithFrame:CGRectMake(kScreenWidth/2, singleHeight*2, kScreenWidth/2, singleHeight) title:@"手持信用卡照片"];
    [_topView addSubview:_sixView];
    [_sixView.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(154), BILIHEIGHT(107)));
        make.top.equalTo(_sixView.mas_top).offset(BILIHEIGHT(15));
        make.left.equalTo(_sixView.mas_left).offset(BILIWIDTH(10));
    }];
    UITapGestureRecognizer *tap6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sixAction:)];
    [_sixView addGestureRecognizer:tap6];
    
    _shuoMingLabel = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_red] alignment:NSTextAlignmentLeft];
    [self addSubview:_shuoMingLabel];
    [_shuoMingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.top.equalTo(_topView.mas_bottom).offset(BILIHEIGHT(10));
    }];
    _shuoMingLabel.text = @"注: 上传的银行卡只能为信用卡，绑定后不可随意修改。";
    
    _nextBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(nextAction:) target:self title:@"下一步" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_shuoMingLabel.mas_bottom).offset(BILIHEIGHT(20));
    }];
    ViewRadius(_nextBtn, BILIHEIGHT(5));
}

// 赋值
- (void)setValueWithDictionary:(NSDictionary *)dictionary{
    if (dictionary) {
        [_firstView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"idcard_positive"]] placeholderImage:kGetImage(@"zhengjz")];
        [_secondView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"idcard_opposite"]] placeholderImage:kGetImage(@"zhengjz")];
        [_thirdView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"idcard_hold"]] placeholderImage:kGetImage(@"zhengjz")];
        [_forthView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"bank_positive"]] placeholderImage:kGetImage(@"zhengjz")];
        [_fifthView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"bank_opposite"]] placeholderImage:kGetImage(@"zhengjz")];
        [_sixView.imgView sd_setImageWithURL:[NSURL URLWithString:dictionary[@"bank_hold"]] placeholderImage:kGetImage(@"zhengjz")];
    }
}

// 下一步
- (void)nextAction:(UIButton *)sender{
    if (self.nextBlock) {
        self.nextBlock(_fifthView.imgView.image, _secondView.imgView.image, _thirdView.imgView.image, _forthView.imgView.image, _fifthView.imgView.image, _sixView.imgView.image);
    }
}

//
- (void)firstAction:(UITapGestureRecognizer *)sender{
    if (self.firstBlock) {
        self.firstBlock(_fifthView.imgView.image);
    }
}

- (void)secondAction:(UITapGestureRecognizer *)sender{
    if (self.secondBlock) {
        self.secondBlock(_secondView.imgView.image);
    }
}

- (void)thirdAction:(UITapGestureRecognizer *)sender{
    if (self.thirdBlock) {
        self.thirdBlock(_thirdView.imgView.image);
    }
}

- (void)forthAction:(UITapGestureRecognizer *)sender{
    if (self.forthBlock) {
        self.forthBlock(_forthView.imgView.image);
    }
}

- (void)fifthAction:(UITapGestureRecognizer *)sender{
    if (self.fifthBlock) {
        self.fifthBlock(_fifthView.imgView.image);
    }
}

- (void)sixAction:(UITapGestureRecognizer *)sender{
    if (self.sixBlock) {
        self.sixBlock(_sixView.imgView.image);
    }
}

@end





@implementation DYIdentityAuthSingleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title{
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    _imgView.image = kGetImage(@"zhengjz");
    _imgView.userInteractionEnabled = YES;
    
    _label = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_label];
    _label.text = title;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_imgView.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-5));
    }];
}

@end
