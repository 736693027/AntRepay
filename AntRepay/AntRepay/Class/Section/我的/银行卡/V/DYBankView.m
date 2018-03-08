//
//  DYBankView.m
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/2.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYBankView.h"
#import "DYAddRepaymentView.h"

@implementation DYBankView


@end

@interface DYBankCell ()

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *changeLabel;

@end

static NSString *const _image_bank_bj = @"bank_bj";
static NSString *const _image_bank_add = @"bank_add";

@implementation DYBankCell

- (void)dy_initUI {
    [super dy_initUI];
    [self xhq_noneSelectionStyle];
    self.hideSeparatorLabel = YES;
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.numLabel];
    [self addSubview:self.changeLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.edges.equalTo(0);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(BILIWIDTH(20));
    }];
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.centerY.equalTo(0);
        make.right.equalTo(BILIWIDTH(-20));
    }];
    [_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(BILIHEIGHT(-20));
    }];
}

#pragma mark - 修改
- (void)tapMethod {
    if (self.block) {
        self.block();
    }
}

#pragma mark - setter
- (void)setBankModel:(DYBankModel *)bankModel {
    _bankModel = bankModel;
    if ([NSString xhq_notEmpty:bankModel.bank_num] &&
        [NSString xhq_notEmpty:bankModel.bank_name]) {
        
        self.bgImageView.image = [UIImage imageNamed:_image_bank_bj];
        self.titleLabel.hidden = self.numLabel.hidden = self.changeLabel.hidden = NO;
        
        NSString *prefix = [bankModel.bank_num substringToIndex:4];
        NSString *suffix = [bankModel.bank_num substringFromIndex:bankModel.bank_num.length - 3];
        _titleLabel.text = bankModel.bank_name;
        _numLabel.text = [NSString stringWithFormat:@"%@ **** **** **** %@", prefix, suffix];
        
        [_titleLabel wordSpace:2];
        [_numLabel wordSpace:1.5];
    }else {
        self.bgImageView.image = [UIImage imageNamed:_image_bank_add];
        self.titleLabel.hidden = self.numLabel.hidden = self.changeLabel.hidden = YES;
    }
}

#pragma mark - getter
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_bank_bj]];
    }
    return _bgImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                          font:[UIFont xhq_font16]
                                          text:@"中国XX银行"];
    }
    return _titleLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                        font:XHQ_FONT(28)
                                        text:@"6227 **** **** **** 676"];
        _numLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _numLabel;
}

- (UILabel *)changeLabel {
    if (!_changeLabel) {
        _changeLabel = [UILabel xhq_layoutColor:[UIColor whiteColor]
                                           font:[UIFont xhq_font14]
                                           text:@"修改"];
        _changeLabel.transform = CGAffineTransformMake(1, 0, tanf(-10 * (CGFloat)M_PI / 180), 1, 0, 0);
        [_changeLabel attribute:@{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)}
                          range:NSMakeRange(0, 2)];
        _changeLabel.userInteractionEnabled = YES;
        [_changeLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(tapMethod)]];
    }
    return _changeLabel;
}

@end

#pragma mark - DYbankAddCell 添加银行卡cell
@interface DYbankAddCell ()<UITextFieldDelegate>

@property (nonatomic, strong) DYAddRepaymentSingleView *input;
@property (nonatomic, strong) UIButton *fillButton;
@property (nonatomic, strong) UIButton *codeButton;

@end

@implementation DYbankAddCell

- (void)dy_initUI {
    [super dy_initUI];
    [self xhq_noneSelectionStyle];
    
    [self addSubview:self.input];
    [self addSubview:self.codeButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_input makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_fillButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    [_codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(94), BILIHEIGHT(26)));
        make.right.equalTo(BILIWIDTH(BILIWIDTH(-15)));
        make.centerY.equalTo(_input.textField.mas_centerY);
    }];
}

#pragma mark - 下拉选择
- (void)dropDownSelected {
    [_input resignFirstResponder];
    if (self.dropDownBlock) {
        self.dropDownBlock();
    }
}

#pragma mark - 获取验证码
- (void)codeButtonClicked {
    [_input resignFirstResponder];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    if (self.codeBlock) {
        self.codeBlock();
    }
}

#pragma mark - UITextFiledDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (_inputModel.selected || _inputModel.disEnabled) {
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [textField input:string limit:@"0123456789"];
}

- (void)textFieldDidChanged:(UITextField *)textField {
    _inputModel.inputString = textField.text;
}

#pragma mark - setter
- (void)setInputModel:(DYBankAddInputModel *)inputModel {
    _inputModel = inputModel;
    
    _input.titleLable.text = inputModel.title;
    _input.textField.text = inputModel.inputString;
    _input.textField.placeholder = inputModel.placeholder;
    _input.xiaLaBtn.hidden = !inputModel.selected;
    _fillButton.hidden = !inputModel.selected;
    _codeButton.hidden = !inputModel.countDown;
    if (inputModel.countDown && inputModel.startCountDown) {
        [Utils getTimeWithButton:_codeButton];
    }
}

#pragma mark - getter
- (DYAddRepaymentSingleView *)input {
    if (!_input) {
        _input = [[DYAddRepaymentSingleView alloc]initWithFrame:CGRectZero title:@"标题" placeHolder:@"输入标题"];
        [_input.textField setNumbersKeyboard];
        _input.textField.delegate = self;
        [_input.textField addTarget:self action:@selector(textFieldDidChanged:)
                   forControlEvents:UIControlEventEditingChanged];
        [_input addSubview:self.fillButton];
    }
    return _input;
}

- (UIButton *)fillButton {
    if (!_fillButton) {
        _fillButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fillButton xhq_addTarget:self action:@selector(dropDownSelected)];
    }
    return _fillButton;
}

- (UIButton *)codeButton {
    if (!_codeButton) {
        _codeButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor whiteColor]
                                     titleColor:[UIColor xhq_green]
                                    borderWidth:1
                                    borderColor:[UIColor xhq_green].CGColor
                                   cornerRadius:BILIHEIGHT(12.5)
                                            tag:0
                                         target:self
                                         action:@selector(codeButtonClicked)
                                          title:@"获取验证码"];
        _codeButton.xhqFont = [UIFont xhq_font12];
    }
    return _codeButton;
}

@end
