//
//  DYFilterView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYFilterView.h"

@interface DYFilterView ()
@property (nonatomic, strong) UILabel *typeTitleLabel;
@property (nonatomic, strong) UIButton *typeBtn;  // 选择类型按钮
@property (nonatomic, strong) UILabel *timeTitleLabel;
@property (nonatomic, strong) UILabel *midLabel;
@property (nonatomic, strong) UIButton *deleteBtn; // 删除按钮
@end

@implementation DYFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _typeTitleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_typeTitleLabel];
    [_typeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(11));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(17));
    }];
    _typeTitleLabel.text = @"类型选择";
    
    _typeView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(40), kScreenWidth, BILIHEIGHT(42)) title:@"" placeHolder:@"请选择类型"];
    [self addSubview:_typeView];
    _typeView.titleLable.hidden = YES;
    [_typeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_typeView.mas_left).offset(BILIWIDTH(20));
        make.right.equalTo(_typeView.mas_right).offset(BILIWIDTH(-10));
        make.bottom.equalTo(_typeView.mas_bottom).offset(BILIHEIGHT(-8));
        make.height.mas_equalTo(BILIHEIGHT(32));
    }];
    
    _typeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(typeAction:) target:self title:nil image:nil font:0 textColor:nil];
    [_typeView addSubview:_typeBtn];
    [_typeView addSubview:_typeBtn];
    [_typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_typeView);
    }];
    
    _timeTitleLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_timeTitleLabel];
    _timeTitleLabel.text = @"时间选择";
    [_timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_typeTitleLabel.mas_left);
        make.top.equalTo(_typeView.mas_bottom).offset(BILIHEIGHT(17));
    }];
    
    _startView = [[DYFilterSingleView alloc] initWithFrame:CGRectMake(BILIWIDTH(10), BILIHEIGHT(117), BILIWIDTH(154), BILIHEIGHT(40)) placeHolder:@"开始时间"];
    [self addSubview:_startView];
    [_startView.button addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _midLabel = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_midLabel];
    [_midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(_startView.mas_centerY);
    }];
    _midLabel.text = @"至";
    
    _endView = [[DYFilterSingleView alloc] initWithFrame:CGRectMake(BILIWIDTH(209), BILIHEIGHT(117), BILIWIDTH(154), BILIHEIGHT(40)) placeHolder:@"结束时间"];
    [self addSubview:_endView];
    [_endView.button addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _deleteBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(deleteAction:) target:self title:nil image:@"chzhi" font:0 textColor:nil];
    [self addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(CGSizeMake(BILIWIDTH(73), BILIHEIGHT(41)));
        make.right.equalTo(self.mas_right);
        make.top.equalTo(_endView.mas_bottom).offset(BILIWIDTH(4));
    }];
    _deleteBtn.imageEdgeInsets = UIEdgeInsetsMake(0, BILIWIDTH(10), 0, 0);
}

// 类型
- (void)typeAction:(UIButton *)sender{
    if (self.typeBlock) {
        self.typeBlock(_typeView.textField.text);
    }
}

// 开始时间
- (void)startAction:(UIButton *)sender{
    if (self.startTimeBlock) {
        self.startTimeBlock(_startView.textField.text,@"1");
    }
}

// 结束时间
- (void)endAction:(UIButton *)sender{
    if (self.endTimeBlock) {
        self.endTimeBlock(_endView.textField.text,@"2");
    }
}

// 删除
- (void)deleteAction:(UIButton *)sender{
    _startView.textField.text = @"";
    _endView.textField.text = @"";
}

@end




#pragma mark ------------- single view
@implementation DYFilterSingleView

- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithPlaceHolder:placeHolder];
    }
    return self;
}

- (void)setupUIWithPlaceHolder:(NSString *)placeHolder{
    _textField = [[UITextField alloc] init];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _textField.placeholder = placeHolder;
    _textField.font = kFont(13);
    _textField.textAlignment = NSTextAlignmentCenter;
    _textField.textColor = [UIColor xhq_base];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
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

@end
