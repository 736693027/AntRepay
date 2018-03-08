//
//  DYMineZhangDanCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMineZhangDanCell.h"

@interface DYMineZhangDanCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *valueArray;

@end

static NSString *const cellIdentifier = @"mineZhangDanIdentifier";

@implementation DYMineZhangDanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYMineZhangDanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYMineZhangDanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _imgView = [Utils imageView];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BILIWIDTH(37), BILIWIDTH(37)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _titleLable = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(10));
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(17));
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-11));
        make.left.equalTo(_titleLable.mas_left);
    }];
    
    _moneyLabel = [Utils labelWithTitleFontSize:16 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
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

- (void)setTypeArray:(NSArray *)typeArray {
    _typeArray = typeArray;
    _nameArray = @[].mutableCopy;
    _valueArray = @[].mutableCopy;
    for (DYMineZhangDanTypeModel *model in typeArray) {
        [_nameArray addObject:model.name];
        [_valueArray addObject:model.value];
    }
}

-(void)setValueWithModel:(DYMineZhangDanModel *)model{
    //@"分润入账", @"申请提款", @"提现成功", @"提现失败"
    if (model) {
        if ([model.type intValue] == 2){//
            _imgView.image = kGetImage(@"djie_smal");
            _titleLable.text = @"申请提现";
        }else if ([model.type intValue] == 4){ //
            _imgView.image = kGetImage(@"jdong_smal");
            _titleLable.text = @"提现失败";
        }else if ([model.type intValue] == 3){//
            _imgView.image = kGetImage(@"kchu_smal");
            _titleLable.text = @"提现成功";
        }else if ([model.type integerValue] == 1) { //
            _titleLable.text = @"分润入账";
            _imgView.image = kGetImage(@"tuig_small");
        }
        if (self.nameArray.count > 0) {
            _titleLable.text = self.nameArray[[self.valueArray indexOfObject:model.type]];
        }
        _moneyLabel.text = model.money;
        _timeLabel.text = [Utils timestampSwitchTime:[model.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(60);
}

@end
