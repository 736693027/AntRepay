//
//  DYTiXianRecordCell.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTiXianRecordCell.h"

@interface DYTiXianRecordCell ()
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *midLabel;
@property (nonatomic, strong) UILabel *rightTopLabel;
@property (nonatomic, strong) UILabel *rightBottomLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@end

static NSString *const cellIdentifier = @"tiXianRecordIdentifier";

@implementation DYTiXianRecordCell


- (void)dy_initUI {
    [super dy_initUI];
    [self setupUI];
}

-(void)setupUI {
    _leftLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_leftLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(12));
        make.top.equalTo(BILIHEIGHT(15));
    }];
    
    _midLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_midLabel];
    [_midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(BILIWIDTH(10));
        make.centerY.equalTo(_leftLabel);
    }];
    
    _rightTopLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentRight];
    [self addSubview:_rightTopLabel];
    [_rightTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-12));
        make.centerY.equalTo(_leftLabel);
    }];
    
    _rightBottomLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:0];
    _rightBottomLabel.numberOfLines = 0;
    _rightBottomLabel.preferredMaxLayoutWidth = kScreenWidth - BILIWIDTH(24);
    [self addSubview:_rightBottomLabel];
    [_rightBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel);
        make.top.equalTo(_leftLabel.bottom).offset(BILIHEIGHT(10));
        make.right.lessThanOrEqualTo(BILIWIDTH(-12));
    }];
    
    self.hyb_lastViewInCell = self.rightBottomLabel;
    self.hyb_bottomOffsetToCell = BILIHEIGHT(15);
}

-(void)setValueWithModel:(DYTiXianRecordModel *)model{
    if (model) {
        _leftLabel.text = [Utils timestampSwitchTime:[model.time integerValue] andFormatter:@"YYYY-MM-dd HH:mm:ss"];
        _rightTopLabel.text = NSStringFormat(@"￥%@",model.money);
        _rightBottomLabel.text = [NSString stringWithFormat:@"处理说明：%@", model.deal_info];
        if ([model.status intValue] == 0) {
            _midLabel.text = @"处理中";
        }else if ([model.status intValue] == 1){
            _midLabel.text = @"成功";
        }else if ([model.status intValue] == 2){
            _midLabel.text = @"失败";
        }
        
        if ([model.status intValue] == 2) {
            _rightBottomLabel.hidden = NO;
            self.hyb_lastViewInCell = self.rightBottomLabel;
        }else {
            _rightBottomLabel.hidden = YES;
            self.hyb_lastViewInCell = self.leftLabel;
        }
    }
}

@end
