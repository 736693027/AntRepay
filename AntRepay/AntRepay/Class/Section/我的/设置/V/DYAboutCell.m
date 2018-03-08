//
//  DYAboutCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAboutCell.h"

@interface DYAboutCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"aboutCellIdentifier";

@implementation DYAboutCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYAboutCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    
    _rightLabel = [Utils labelWithTitleFontSize:14 textColor:KGrayColor alignment:NSTextAlignmentLeft];
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
    if (string) {
        _rightLabel.text = string;
    }
}

/** 标题 **/
- (void)setValueWithTitle:(NSString *)title{
    _leftLabel.text = title;
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(40);
}

@end
