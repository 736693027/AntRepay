//
//  DYTradeDetailCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTradeCell.h"

@interface DYTradeCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *tiXianTitleLabel;
@property (nonatomic, strong) UILabel *weiHaoLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *valueArray;

@end

static NSString *const cellIdentifier = @"TradeIdentifier";

static NSString *const _image_cz = @"chongz_zhb";
static NSString *const _image_tx = @"tixian_zhb";
static NSString *const _image_bnhk = @"kuaishk_zhb";
static NSString *const _image_cxf = @"xiaofei_zhb";
static NSString *const _image_hkxf = @"huankxf_zhb";

@implementation DYTradeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYTradeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYTradeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _timeLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentCenter];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(BILIWIDTH(43));
    }];
    
    _imgView = [Utils imageView];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(35), BILIHEIGHT(34)));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(_timeLabel.mas_right).offset(BILIWIDTH(7));
    }];
    
    _tiXianTitleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_tiXianTitleLabel];
    [_tiXianTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(19));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(14));
    }];
    
    _weiHaoLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_weiHaoLabel];
    [_weiHaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(19));
        make.top.equalTo(_tiXianTitleLabel.mas_bottom).offset(BILIHEIGHT(6));
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-11));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(0.8));
    }];
}

-(void)setValueWithModel:(NSArray *)model{
    _timeLabel.text = @"09-20 19:51";
    _tiXianTitleLabel.text = @"提现";
    _imgView.image = kGetImage(@"chongz_zhb");
    _weiHaoLabel.text = @"尾号(9875)";
    _rightLabel.text = @"￥12.50";
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

- (void)setListModel:(DYBooksListModel *)listModel {
    _listModel = listModel;
    _timeLabel.text = [listModel.time xhq_timeIntervalToStringFromatter:@"MM-dd HH:mm"];
    _imgView.image = [self typeImage];
    _tiXianTitleLabel.text = [self typeTitle];
    _weiHaoLabel.text = [NSString stringWithFormat:@"尾号(%@)",
                         [listModel.bank_num substringFromIndex:listModel.bank_num.length - 4]];
    _rightLabel.text = [NSString stringWithFormat:@"￥%@", listModel.money];
}

- (UIImage *)typeImage {
    switch ([self.listModel.type integerValue]) {
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
    //自动消费，还款
    
    if (self.valueArray.count > 0 && self.nameArray.count > 0 && [NSString xhq_notEmpty:self.listModel.type]) {
        return self.nameArray[[self.valueArray indexOfObject:self.listModel.type]];
    }
    
    switch ([self.listModel.type integerValue]) {
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
    return BILIHEIGHT(62);
}


@end
