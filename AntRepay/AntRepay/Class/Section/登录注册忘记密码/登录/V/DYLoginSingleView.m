//
//  DYLoginSingleView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYLoginSingleView.h"

@implementation DYLoginSingleView

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image placeHolder:(NSString *)placeHolder
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithFrame:frame image:image placeHolder:placeHolder];
    }
    return self;
}

- (void)setupUIWithFrame:(CGRect)frame image:(NSString *)image placeHolder:(NSString *)placeHolder{
    _imgView = [Utils imageViewWithImage:kGetImage(image)];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(21));
        make.bottom.equalTo(self.mas_bottom).offset(BILIWIDTH(-11));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(19), BILIHEIGHT(21)));
    }];
    
    _textField = [MyTools createTextFieldWithFont:14 placeHolder:placeHolder placeHolderFont:14];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView.mas_right).offset(BILIWIDTH(22));
        make.centerY.equalTo(_imgView.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-15));
    }];
    
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
