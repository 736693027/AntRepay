//
//  DYGongGaoCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYGongGaoCell.h"

@interface DYGongGaoCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"gongGaoIdentifier";

@implementation DYGongGaoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    DYGongGaoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[DYGongGaoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

-(void)setupUI{
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(10));
    }];
    
    _timeLabel = [Utils labelWithTitleFontSize:12 textColor:KGrayColor alignment:NSTextAlignmentLeft];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(15));
        make.top.equalTo(_titleLabel.mas_bottom).offset(BILIHEIGHT(8));
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

-(void)setValueWithModel:(DYGongGaoModel *)model{
    if (model) {
        _titleLabel.text = model.title;
        _timeLabel.text = [Utils timestampSwitchTime:[model.time integerValue] andFormatter:@"yyyy-MM-dd HH:mm:ss"];
    }
}

+(CGFloat)cellHeight{
    return BILIHEIGHT(65);
}

@end
