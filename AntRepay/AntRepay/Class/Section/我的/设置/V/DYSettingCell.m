//
//  DYSettingCell.m
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYSettingCell.h"

@interface DYSettingCell ()
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"aboutCell";
static NSString *const cellSecondIdentifier = @"keFuCell";

@implementation DYSettingCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _imgView = [Utils imageViewWithImage:kGetImage(@"xiayib_bla")];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(6), BILIHEIGHT(10)));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
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

- (void)setValueWithString:(NSString *)string{
    _label.text = string;
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(50);
}

@end



#pragma mark ------------------- 客服
@implementation DYSettingSecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYSettingSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSecondIdentifier];
    if (!cell) {
        cell = [[DYSettingSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSecondIdentifier];
    }
    return cell;
}

-(void)setupUI{
    self.backgroundColor = [UIColor xhq_section];
    _backView = [[UIView alloc] init];
    _backView.backgroundColor = KWhiteColor;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(BILIWIDTH(10), 0, 0, 0));
    }];
    
    _label = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.centerY.equalTo(_backView.mas_centerY);
    }];
    _label.text = @"客服电话";
    
    _imgView = [Utils imageViewWithImage:kGetImage(@"morej")];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(6), BILIHEIGHT(10)));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
        make.centerY.equalTo(_backView.mas_centerY);
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_imgView.mas_left).offset(BILIWIDTH(-10));
        make.bottom.equalTo(_backView.mas_bottom).offset(BILIHEIGHT(-10));
    }];
    
    _phoneLabel = [Utils labelWithTitleFontSize:18 textColor:[UIColor xhq_base] alignment:NSTextAlignmentLeft];
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_timeLabel.mas_centerX);
        make.top.equalTo(_backView.mas_top).offset(BILIHEIGHT(10));
    }];
}

-(void)setValueWithPhone:(NSString *)phone time:(NSString *)time{
    if (phone.length) {
        _phoneLabel.text = phone;
    }
    if (time) {
        _timeLabel.text = time;
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(75);
}

@end
