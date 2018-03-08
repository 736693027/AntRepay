//
//  DYAddHuanKuanView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddHuanKuanView.h"
#define singleHeight BILIHEIGHT(45)

@interface DYAddHuanKuanView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *addPlanBtn; // 添加按钮
@property (nonatomic, strong) UIButton *checkListBtn; // 查看列表按钮
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation DYAddHuanKuanView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _timeView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, singleHeight) title:@"还款日期" placeHolder:@"请选择" image:@"riqi"];
    [self addSubview:_timeView];
    [_timeView.button addTarget:self action:@selector(timeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _typeView = [[DYAddXiaoFeiSinglePlanView alloc] initWithFrame:CGRectMake(0, singleHeight, kScreenWidth, singleHeight) title:@"还款类别" placeHolder:@"请选择" image:@"xial_hk"];
    [self addSubview:_typeView];
    _typeView.textField.text = @"蚂蚁还款";
    _typeView.imgView.hidden = YES;
    
    _moneyView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*2, kScreenWidth, singleHeight) title:@"还款总金额" placeHolder:@"请输入还款总金额"];
    [self addSubview:_moneyView];
    _moneyView.xiaLaBtn.hidden = YES;
    _moneyView.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    _chaiView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, singleHeight*3, kScreenWidth, singleHeight) title:@"拆分笔数" placeHolder:@""];
    [self addSubview:_chaiView];
    _chaiView.textField.hidden = YES;
    _chaiView.xiaLaBtn.hidden = YES;
    
    _subBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(subAction:) target:self title:nil image:@"shao_gray" font:0 textColor:nil];
    [_chaiView addSubview:_subBtn];
    [_subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(17), BILIWIDTH(17)));
        make.centerY.equalTo(_chaiView.titleLable.mas_centerY);
        make.right.equalTo(_chaiView.mas_right).offset(BILIWIDTH(-70));
    }];
    
    _addBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(addAction:) target:self title:nil image:@"jia_black" font:0 textColor:nil];
    [_chaiView addSubview:_addBtn];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(17), BILIWIDTH(17)));
        make.centerY.equalTo(_chaiView.titleLable.mas_centerY);
        make.right.equalTo(_chaiView.mas_right).offset(BILIWIDTH(-23));
    }];
    
    _addPlanBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(addPlanAction:) target:self title:@"增加计划至列表" image:nil font:14 textColor:KWhiteColor];
    [self addSubview:_addPlanBtn];
    [_addPlanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_chaiView.mas_bottom).offset(BILIHEIGHT(40));
    }];
    ViewRadius(_addPlanBtn, BILIHEIGHT(5));

    _checkListBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(addPlanAction:) target:self title:@"查看列表" image:@"kancha" font:14 textColor:[UIColor xhq_red]];
    [self addSubview:_checkListBtn];
    [_checkListBtn setImageEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(-15), 0, 0)];
    [_checkListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, BILIHEIGHT(40)));
        make.top.equalTo(_addPlanBtn.mas_bottom).offset(BILIHEIGHT(5));
        make.centerX.equalTo(self.mas_centerX);
    }];
    
//    _label = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
//    [self addSubview:_label];
//    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_subBtn.mas_right);
//        make.right.equalTo(_addBtn.mas_left);
//        make.centerY.equalTo(_subBtn.mas_centerY);
//    }];
//    _label.text = @"1";
    
    _textField = [[UITextField alloc]init];
    _textField.text = @"1";
    [_textField setNumbersKeyboard];
    _textField.font = [UIFont xhq_font12];
    _textField.textColor = [UIColor xhq_aTitle];
    _textField.textAlignment = 1;
    _textField.delegate = self;
    [self addSubview:_textField];
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_subBtn.mas_right);
        make.right.equalTo(_addBtn.mas_left);
        make.centerY.equalTo(_subBtn.mas_centerY);
    }];
}

// 还款日期
- (void)timeAction:(UIButton *)sender{
    if (self.dateBlock) {
        self.dateBlock();
    }
}

// 减少
- (void)subAction:(UIButton *)sender{
    if ([_textField.text intValue] <= 1) {
        _textField.text = @"1";
        return;
    }
    _textField.text = NSStringFormat(@"%d",[_textField.text intValue] - 1);
}

// 增加
- (void)addAction:(UIButton *)sender{
    _textField.text = NSStringFormat(@"%d",[_textField.text intValue] + 1);
}

// 增加计划至列表
- (void)addPlanAction:(UIButton *)sender{
    if (!_timeView.textField.text.length) {
        [DYShowView ShowWithText:@"请选择还款日期"];
    }else if (!_moneyView.textField.text){
        [DYShowView ShowWithText:@"请输入需要生成计划的总金额"];
    }else if (![NSString xhq_notEmpty:_textField.text tip:@"拆分笔数"]) {
        
    }else{
        [self endEditing:YES];
        if (self.addPlanBlock) {
            self.addPlanBlock(_timeView.textField.text, _moneyView.textField.text, _textField.text);
        }
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField input:string limit:@"1234567890"];
}

@end
