//
//  DYZhangDanDetailView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYZhangDanDetailView.h"
#import "DYMineZhangDanModel.h"

#define singleHeight BILIHEIGHT(35)

@interface DYZhangDanDetailView()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) DYZhangDanDetailSingleView *yuEView;
@property (nonatomic, strong) DYZhangDanDetailSingleView *dongJieView;
@property (nonatomic, strong) DYZhangDanDetailSingleView *timeView;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) DYZhangDanDetailSingleView *miaoShuView;

@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *valueArray;

@end

@implementation DYZhangDanDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.backgroundColor = KWhiteColor;
    _imgView = [Utils imageView];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(28), BILIWIDTH(28)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(137));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(17));
    }];
    
    _titleLabel = [Utils labelWithTitleFontSize:16 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(7));
        make.centerY.equalTo(_imgView.mas_centerY);
    }];
    
    _moneyLabel = [Utils labelWithTitleFontSize:30 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(67));
    }];
    
    _stateLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentCenter];
    [self addSubview:_stateLabel];
    [_stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_moneyLabel.mas_bottom).offset(BILIHEIGHT(7));
    }];
    
    _yuEView = [[DYZhangDanDetailSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(155), kScreenWidth, singleHeight) title:@"账户余额"];
    [self addSubview:_yuEView];
    
    _dongJieView = [[DYZhangDanDetailSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(155)+singleHeight, kScreenWidth, singleHeight) title:@"冻结金额"];
    [self addSubview:_dongJieView];
    
    _timeView = [[DYZhangDanDetailSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(155)+singleHeight*2, kScreenWidth, singleHeight) title:@"交易时间"];
    [self addSubview:_timeView];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.height.mas_equalTo(BILIHEIGHT(1));
        make.top.equalTo(_timeView.mas_bottom).offset(BILIHEIGHT(8));
    }];
    
    _miaoShuView = [[DYZhangDanDetailSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(268), kScreenWidth, BILIHEIGHT(72)) title:@"交易描述"];
    [self addSubview:_miaoShuView];
    
}

#pragma mark - setter

- (void)setTypeArray:(NSArray *)typeArray {
    _typeArray = typeArray;
    _nameArray = @[].mutableCopy;
    _valueArray = @[].mutableCopy;
    for (DYMineZhangDanTypeModel *model in typeArray) {
        [_nameArray addObject:model.name];
        [_valueArray addObject:model.value];
    }
}

- (void)setValueWithDictionary:(NSDictionary *)dictionary{
    //@"分润入账", @"申请提款", @"提现成功", @"提现失败"
    if (dictionary) {
        _yuEView.rightLabel.text = NSStringFormat(@"￥%@",dictionary[@"account_money"]);
        _dongJieView.rightLabel.text = NSStringFormat(@"￥%@",dictionary[@"freeze_money"]);
        NSString *time = dictionary[@"time"];
        _timeView.rightLabel.text = [Utils timestampSwitchTime:[time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        _miaoShuView.rightLabel.text = dictionary[@"info"];
        NSString *type = dictionary[@"type"];
        if ([type intValue] == 2){//
            _imgView.image = kGetImage(@"djie_smal");
            _titleLabel.text = @"申请提现";
        }else if ([type intValue] == 4){ //
            _imgView.image = kGetImage(@"jdong_smal");
            _titleLabel.text = @"提现失败";
        }else if ([type intValue] == 3){//
            _imgView.image = kGetImage(@"kchu_smal");
            _titleLabel.text = @"提现成功";
        }else if ([type integerValue] == 1) { //
            _titleLabel.text = @"分润入账";
            _imgView.image = kGetImage(@"tuig_small");
        }
        if (self.nameArray.count > 0) {
            _titleLabel.text = self.nameArray[[self.valueArray indexOfObject:type]];
        }
        _moneyLabel.text = dictionary[@"money"];
    }
}

@end




#pragma mark -------------------- single view

@implementation DYZhangDanDetailSingleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title{
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(14));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(12));
    }];
    _titleLabel.text = title;
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-14));
        make.top.equalTo(_titleLabel.mas_top);
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(100));
    }];
}

@end
