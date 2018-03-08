//
//  DYBaoZhengJinCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBaoZhengJinCell.h"

@interface DYBaoZhengJinCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"baoZhengJinCellIdentifier";
static NSString *const cellIdentifier2 = @"baoZhengJinYuECellIdentifier";

@implementation DYBaoZhengJinCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYBaoZhengJinCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYBaoZhengJinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _leftLabel = [Utils labelWithTitleFontSize:13 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(14));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_rightLabel];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-14));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(BILIHEIGHT(0.8)));
    }];
}

// 设置title
- (void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

- (void)setValueWithString:(NSString *)model{
    _rightLabel.text = NSStringFormat(@"￥%@",model);
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(43);
}

@end




#pragma mark ----------------- 支付保证金账户余额cell
@interface DYBaoZhengYuECell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *rechargeLabel;
@property (nonatomic, strong) UIButton *rightBtn;
@end
@implementation DYBaoZhengYuECell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYBaoZhengYuECell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier2];
    if (!cell) {
        cell = [[DYBaoZhengYuECell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier2];
    }
    return cell;
}

-(void)setupUI{
    _imgView = [Utils imageViewWithImage:kGetImage(@"zhyue")];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(20), BILIHEIGHT(19)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _moneyLabel = [Utils labelWithTitleFontSize:13 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_moneyLabel];
    [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(9));
        make.centerY.equalTo(self.mas_centerY);
    }];
    _moneyLabel.text = @"账户余额 ￥0.00";
    NSMutableAttributedString *string = [MyTools attributeWithString:_moneyLabel.text range:NSMakeRange(4, _moneyLabel.text.length-4) font:12 textColor:[UIColor xhq_red]];
    [_moneyLabel setAttributedText:string];
    
    _rechargeLabel = [UILabel xhq_layoutColor:[UIColor redColor]
                                         font:[UIFont xhq_font12]
                                         text:@"充值"];
    [_rechargeLabel attribute:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}
                   range:NSMakeRange(0, _rechargeLabel.text.length)];
    _rechargeLabel.userInteractionEnabled = YES;
    [_rechargeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                           action:@selector(rechargeTap)]];
    [self addSubview:_rechargeLabel];
    [_rechargeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_moneyLabel.mas_right).offset(BILIWIDTH(5));
        make.centerY.equalTo(_moneyLabel);
    }];
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_rightBtn];
    [_rightBtn setImage:kGetImage(@"xuznz_blue") forState:UIControlStateSelected];
    _rightBtn.selected = YES;
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(17), BILIHEIGHT(18)));
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-23));
    }];
}

-(void)setValueWithString:(NSString *)model{
    _moneyLabel.text = NSStringFormat(@"账户余额 ￥%@",model);
    NSMutableAttributedString *string = [MyTools attributeWithString:_moneyLabel.text range:NSMakeRange(4, _moneyLabel.text.length-4) font:12 textColor:[UIColor xhq_red]];
    [_moneyLabel setAttributedText:string];
}

#pragma mark - 充值
- (void)rechargeTap {
    if (self.block) {
        self.block();
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(45);
}

@end
