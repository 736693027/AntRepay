//
//  DYTradeDetailCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTradeDetailCell.h"

static NSString *const firstCellIdentifier = @"TradeDetailFirstIdentifier";
static NSString *const secondCellIdentifier = @"TradeDetailSecondIdentifier";
static NSString *const thirdCellIdentifier = @"TradeDetailThirdIdentifier";

static NSString *const _image_cz = @"chongz_zhb";
static NSString *const _image_tx = @"tixian_zhb";
static NSString *const _image_bnhk = @"kuaishk_zhb";
static NSString *const _image_cxf = @"xiaofei_zhb";
static NSString *const _image_hkxf = @"huankxf_zhb";

@interface DYTradeDetailCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYTradeDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYTradeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
    if (!cell) {
        cell = [[DYTradeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(15));
    }];
    
    _moneyLabel = [Utils labelWithTitleFontSize:30 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(48));
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

-(void)setValueWithModel:(NSArray *)model{
    _titleLabel.text = @"交易成功";
    _moneyLabel.text = @"-￥12.50";
}

- (void)setDetailModel:(DYBooksDetailModel *)detailModel {
    _detailModel = detailModel;
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@", detailModel.money];
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(114);
}

@end




#pragma mark -------------- 带图片cell
@interface DYTradeDetailSecondCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *valueArray;

@end

@implementation DYTradeDetailSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYTradeDetailSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:secondCellIdentifier];
    if (!cell) {
        cell = [[DYTradeDetailSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:secondCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _imgView = [Utils imageView];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(35), BILIHEIGHT(34)));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(11));
    }];
    
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
}

-(void)setValueWithModel:(NSArray *)model{
    _imgView.image = kGetImage(@"chongz_zhb");
    _label.text = @"提现";
}

- (void)setTypeArray:(NSArray *)typeArray {
    _typeArray = typeArray;
    _nameArray = [[NSMutableArray alloc]init];
    _valueArray = [[NSMutableArray alloc]init];
    
    for (DYBooksTypeModel *model in typeArray) {
        [_nameArray addObject:model.name];
        [_valueArray addObject:model.value];
    }
}

- (void)setDetailModel:(DYBooksDetailModel *)detailModel {
    _detailModel = detailModel;
    _imgView.image = [self typeImage];
    _label.text = [self typeTitle];
}

- (UIImage *)typeImage {
    switch ([self.detailModel.order_type integerValue]) {
//        case 1: //充值
//            return [UIImage imageNamed:_image_cz];
//        case 2: //提现
//            return [UIImage imageNamed:_image_tx];
        case 1: //还款消费
            return [UIImage imageNamed:_image_hkxf];
        case 2: //帮你还款
            return [UIImage imageNamed:_image_bnhk];
//        case 5: //纯消费
//            return [UIImage imageNamed:_image_cxf];
        default:
            return [UIImage imageNamed:_image_hkxf];
    }
}

- (NSString *)typeTitle {
    
    if (self.valueArray.count > 0 && self.nameArray.count > 0 && [NSString xhq_notEmpty:self.detailModel.order_type]) {
        return self.nameArray[[self.valueArray indexOfObject:self.detailModel.order_type]];
    }
    
    switch ([self.detailModel.order_type integerValue]) {
//        case 1: //充值
//            return @"充值";
//        case 2: //提现
//            return @"提现";
        case 1: //还款消费
            return @"还款消费";
        case 2: //帮你还款
            return @"帮你还款";
//        case 5: //纯消费
//            return @"纯消费";
        default:
            return @"还款消费";
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(63);
}

@end




#pragma mark -------------- 带图片cell
@interface DYTradeDetailThirdCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

@implementation DYTradeDetailThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYTradeDetailThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:thirdCellIdentifier];
    if (!cell) {
        cell = [[DYTradeDetailThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:thirdCellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:0];
    _rightLabel.numberOfLines = 2;
    _rightLabel.preferredMaxLayoutWidth = BILIWIDTH(300);
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
        make.centerY.equalTo(self.mas_centerY);
        make.width.lessThanOrEqualTo(BILIWIDTH(260));
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

-(void)setValueWithModel:(NSString *)model{
    _rightLabel.text = model;
}

// 标题
- (void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end
