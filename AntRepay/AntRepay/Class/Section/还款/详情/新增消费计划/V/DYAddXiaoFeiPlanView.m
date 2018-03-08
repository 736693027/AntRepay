//
//  DYAddXiaoFeiPlanView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddXiaoFeiPlanView.h"
#define singleHeight BILIHEIGHT(44)

@interface DYAddXiaoFeiPlanView ()
@property (nonatomic, strong) UIButton *yuLanBtn; // 预览计划
@property (nonatomic, strong) UIButton *submitBtn; // 提交按钮
@end

@implementation DYAddXiaoFeiPlanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _startTimeView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(50)) title:@"开始日期" placeHolder:@"请选择" image:@"riqi"];
    [self addSubview:_startTimeView];
    [_startTimeView.button addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _endTimeView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50), kScreenWidth, singleHeight) title:@"结束日期" placeHolder:@"请选择" image:@"riqi"];
    [self addSubview:_endTimeView];
    [_endTimeView.button addTarget:self action:@selector(endAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _repeatTypeView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50)+singleHeight, kScreenWidth, singleHeight) title:@"重复类型" placeHolder:@"请选择" image:@"xial_hk"];
    [self addSubview:_repeatTypeView];
    [_repeatTypeView.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(10), BILIHEIGHT(6)));
        make.centerY.equalTo(_repeatTypeView.titleLable.mas_centerY);
        make.right.equalTo(_repeatTypeView.mas_right).offset(BILIWIDTH(-21));
    }];
    [_repeatTypeView.button addTarget:self action:@selector(repeatTypeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _repeatContentView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50)+singleHeight*2, kScreenWidth, singleHeight) title:@"重复内容" placeHolder:@"请选择" image:@"xial_hk"];
    [_repeatContentView.imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(10), BILIHEIGHT(6)));
        make.centerY.equalTo(_repeatContentView.titleLable.mas_centerY);
        make.right.equalTo(_repeatContentView.mas_right).offset(BILIWIDTH(-21));
    }];
    [self addSubview:_repeatContentView];
    [_repeatContentView.button addTarget:self action:@selector(repeatContentAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _consumeView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50)+singleHeight*3, kScreenWidth, singleHeight) title:@"消费金额" placeHolder:@"请输入每次消费金额"];
    [self addSubview:_consumeView];
    _consumeView.xiaLaBtn.hidden = YES;
    _consumeView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    
    _yuLanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(yuLanActino:) target:self title:@"预览计划" image:@"kancha" font:14 textColor:[UIColor xhq_red]];
    [self addSubview:_yuLanBtn];
    [_yuLanBtn setImageEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(-15), 0, 0)];
    [_yuLanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, BILIHEIGHT(40)));
        make.top.equalTo(_consumeView.mas_bottom).offset(BILIHEIGHT(20));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    _submitBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(yuLanActino:) target:self title:@"提交" image:nil font:16 textColor:KWhiteColor];
    [self addSubview:_submitBtn];
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_yuLanBtn.mas_bottom).offset(BILIHEIGHT(12));
    }];
    ViewRadius(_submitBtn, BILIHEIGHT(5));
}

// 开始日期
- (void)startAction:(UIButton *)sender{
    if (self.startTimeBlock) {
        self.startTimeBlock(_startTimeView.textField.text);
    }
}

// 结束日期
- (void)endAction:(UIButton *)sender{
    if (self.endTimeBlock) {
        self.endTimeBlock(_endTimeView.textField.text);
    }
}

// 重复类型
- (void)repeatTypeAction:(UIButton *)sender{
    if (self.repeatTypeBlock) {
        self.repeatTypeBlock(_repeatContentView.textField.text);
    }
}

// 重复内容
- (void)repeatContentAction:(UIButton *)sender{
    if (self.repeatContentBlock) {
        self.repeatContentBlock(_repeatContentView.textField.text);
    }
}

// 预览计划
- (void)yuLanActino:(UIButton *)sender{
    if (!_startTimeView.textField.text.length) {
        [DYShowView ShowWithText:@"请选择开始日期"];
    }else if (!_endTimeView.textField.text.length){
        [DYShowView ShowWithText:@"请选择结束日期"];
    }else if (!_repeatTypeView.textField.text.length){
        [DYShowView ShowWithText:@"请选择重复类型"];
    }else if (!_repeatContentView.textField.text.length){
        [DYShowView ShowWithText:@"请选择重复内容"];
    }else if (!_consumeView.textField.text.length){
        [DYShowView ShowWithText:@"请输入每次消费金额"];
    }else{
        self.payModel.startDateString = _startTimeView.textField.text;
        self.payModel.endDateString = _endTimeView.textField.text;
        self.payModel.repeatContent = _repeatContentView.textField.text;
        self.payModel.money = _consumeView.textField.text;
        
        NSString *repeatType = _repeatTypeView.textField.text;
        if ([repeatType isEqualToString:@"每周"]) {
            self.payModel.repeatType = payPlanRepeatTypeWeek;
        }
        else if ([repeatType isEqualToString:@"每月"]) {
            self.payModel.repeatType = payPlanRepeatTypeMonth;
        }
        else if ([repeatType isEqualToString:@"每天"]) {
            self.payModel.repeatType = payPlanRepeatTypeDays;
        }
        
        if (self.planYuLanBlock) {
            self.planYuLanBlock();
        }
    }
}

@end



#pragma mark ---------------- single view
@implementation DYAddXiaoFeiSinglePlanView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder image:(NSString *)image
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title placeHolder:placeHolder image:image];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder image:(NSString *)image{
    _titleLable = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [self addSubview:_titleLable];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(14));
        make.bottom.equalTo(self.mas_bottom).offset(BILIHEIGHT(-10));
    }];
    _titleLable.text = title;
    
    _textField = [MyTools createTextFieldWithFont:14 placeHolder:placeHolder placeHolderFont:14];
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(109));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-40));
        make.centerY.equalTo(_titleLable.mas_centerY);
        make.height.mas_equalTo(BILIHEIGHT(32));
    }];
    
    _lineLabel = [UILabel xhq_lineLabel];
    [self addSubview:_lineLabel];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIHEIGHT(-10));
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(BILIHEIGHT(1));
    }];
    
    _imgView = [Utils imageView];
    [self addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(16), BILIHEIGHT(16)));
        make.centerY.equalTo(_titleLable.mas_centerY);
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-20));
    }];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.image = kGetImage(image);
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_textField.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
    }];
}

@end
