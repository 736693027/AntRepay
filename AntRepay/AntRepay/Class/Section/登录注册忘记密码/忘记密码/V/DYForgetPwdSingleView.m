//
//  DYForgetPwdSingleView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYForgetPwdSingleView.h"

@implementation DYForgetPwdSingleView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIFrame:frame WithTitle:title placeHolder:placeHolder];
    }
    return self;
}

- (void)setupUIFrame:(CGRect)frame WithTitle:(NSString *)title  placeHolder:(NSString *)placeHolder{
    _titleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(14));
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-10));
    }];
    _titleLabel.text = title;
    
    _textField = [MyTools createTextFieldWithFont:14 placeHolder:placeHolder placeHolderFont:14];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(106));
        make.centerY.equalTo(_titleLabel.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
    }];
    _textField.placeholder = placeHolder;
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
        make.height.mas_equalTo(BILIHEIGHT(0.8));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

@end
