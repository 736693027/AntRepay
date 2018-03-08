//
//  DYAddRepaymentView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddRepaymentView.h"
#define singleHeight BILIHEIGHT(43)

@interface DYAddRepaymentView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *zhangDanBtn; // 选择账单日按钮
@property (nonatomic, strong) UIButton *huanKuanBtn; // 还款日按钮
@property (nonatomic, strong) UILabel *beiZhuLabel; // 备注
@property (nonatomic, strong) UIButton *addCardBtn; // 添加信用卡按钮
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *TermButton; //有效期按钮
@property (nonatomic, strong) UIButton *issuingBankButton; //发卡银行

@end

@implementation DYAddRepaymentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    [self addSubview:self.scrollView];
    
    _nameView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(50)) title:@"真实姓名" placeHolder:@"请输入真实姓名"];
    [self.scrollView addSubview:_nameView];
    _nameView.xiaLaBtn.hidden = YES;
    _nameView.textField.delegate = self;
    
    _idcardView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50), kScreenWidth, singleHeight) title:@"身份证号" placeHolder:@"请输入身份证号"];
    [self.scrollView addSubview:_idcardView];
    _idcardView.xiaLaBtn.hidden = YES;
    _idcardView.textField.delegate = self;
    
    _yinHangView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(50)+singleHeight, kScreenWidth, BILIHEIGHT(63)) title:@"信用卡号" placeHolder:@"请输入信用卡卡号"];
    [self.scrollView addSubview:_yinHangView];
    _yinHangView.textField.keyboardType = UIKeyboardTypeNumberPad;
    _yinHangView.xiaLaBtn.hidden = YES;
    _yinHangView.textField.delegate = self;
    
    _CVN2View = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight, kScreenWidth, singleHeight) title:@"CVN2" placeHolder:@"请输入信用卡背面三位CVN2"];
    _CVN2View.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollView addSubview:_CVN2View];
    _CVN2View.xiaLaBtn.hidden = YES;
    _CVN2View.textField.delegate = self;
    
    _youXiaoQiView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*2, kScreenWidth, singleHeight) title:@"有效期" placeHolder:@"请选择信用卡有效期"];
    [self.scrollView addSubview:_youXiaoQiView];
    _TermButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_TermButton xhq_addTarget:self action:@selector(TermButtonClicked)];
    [_youXiaoQiView addSubview:_TermButton];
    [_TermButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _faYiHangView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*3, kScreenWidth, singleHeight) title:@"发卡银行" placeHolder:@"请选择发卡银行"];
    [self.scrollView addSubview:_faYiHangView];
    _faYiHangView.textField.delegate = self;
    _issuingBankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_issuingBankButton xhq_addTarget:self action:@selector(issuingBankButtonClicked)];
    [_faYiHangView addSubview:_issuingBankButton];
    [_issuingBankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    
    _zhangDanView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*4, kScreenWidth, singleHeight) title:@"账单日" placeHolder:@"请选择账单日"];
    [self.scrollView addSubview:_zhangDanView];
    _zhangDanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_zhangDanView addSubview:_zhangDanBtn];
    [_zhangDanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    [_zhangDanBtn addTarget:self action:@selector(zhangDanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _huanKuanView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*5, kScreenWidth, singleHeight) title:@"还款日" placeHolder:@"请选择还款日"];
    [self.scrollView addSubview:_huanKuanView];
    _huanKuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_huanKuanView addSubview:_huanKuanBtn];
    [_huanKuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, BILIWIDTH(109), 0, 0));
    }];
    [_huanKuanBtn addTarget:self action:@selector(huanKuanAction:) forControlEvents:UIControlEventTouchUpInside];
    
    _phoneView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*6, kScreenWidth, singleHeight) title:@"手机号码" placeHolder:@"请输入银行预留手机号码"];
    _phoneView.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollView addSubview:_phoneView];
    _phoneView.xiaLaBtn.hidden = YES;
    _phoneView.textField.delegate = self;
    
//    _codeView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, BILIHEIGHT(113)+singleHeight*7, kScreenWidth, singleHeight) title:@"验证码" placeHolder:@"请输入验证码"];
//    [self.scrollView addSubview:_codeView];
//    [_codeView.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_codeView.mas_left).offset(BILIWIDTH(109));
//        make.width.mas_equalTo(BILIWIDTH(150));
//        make.centerY.equalTo(_codeView.titleLable.mas_centerY);
//        make.height.mas_equalTo(BILIHEIGHT(32));
//    }];
//    _codeView.xiaLaBtn.hidden = YES;
    
//    _codeBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:KWhiteColor action:@selector(codeAction:) target:self title:@"获取验证码" image:nil font:14 textColor:[UIColor xhq_green]];
//    [_codeView addSubview:_codeBtn];
//    [_codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(94), BILIHEIGHT(26)));
//        make.left.equalTo(_codeView.textField.mas_right);
//        make.centerY.equalTo(_codeView.textField.mas_centerY);
//    }];
//    _codeView.textField.keyboardType = UIKeyboardTypeNumberPad;
//    ViewBorderRadius(_codeBtn, BILIHEIGHT(13), BILIWIDTH(1), [UIColor xhq_green]);
    
    _beiZhuLabel = [Utils labelWithTitleFontSize:12 textColor:[UIColor xhq_red] alignment:NSTextAlignmentLeft];
    [self.scrollView addSubview:_beiZhuLabel];
    [_beiZhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(_phoneView.mas_bottom).offset(BILIHEIGHT(30));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(10));
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
    }];
//    _beiZhuLabel.text = @"注: 添加信用卡即做一笔10元的消费交易作为验证信用卡的正确性";
    
    _addCardBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(addCardAction:) target:self title:@"添加信用卡" image:nil font:14 textColor:KWhiteColor];
    [self.scrollView addSubview:_addCardBtn];
    [_addCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(350), BILIHEIGHT(37)));
        make.top.equalTo(_beiZhuLabel.mas_bottom).offset(BILIHEIGHT(11));
        make.centerX.equalTo(self.mas_centerX);
    }];
    ViewRadius(_addCardBtn, BILIHEIGHT(5));
    
    [self layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(0, _addCardBtn.xhq_bottom + 100);
}

#pragma mark - setter
- (void)setMemberModel:(DYRepaymentMemberModel *)memberModel {
    _memberModel = memberModel;
    _nameView.textField.text = memberModel.realname;
    _idcardView.textField.text = memberModel.idcard;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == _nameView.textField ||
        textField == _idcardView.textField) {
        return NO;
    }
    return YES;
}

#pragma mark - 选择有效期
- (void)TermButtonClicked {
    if (self.termBlock) {
        self.termBlock();
    }
}

#pragma mark - 选择发卡银行
- (void)issuingBankButtonClicked {
    [self endEditing:YES];
    if (self.issuingBlock) {
        self.issuingBlock();
    }
}

// 账单日
- (void)zhangDanAction:(UIButton *)sender{
    [self endEditing:YES];
    if (self.zhangDanRiBlock) {
        self.zhangDanRiBlock();
    }
}

// 还款日
- (void)huanKuanAction:(UIButton *)sender{
    [self endEditing:YES];
    if (self.huanKuanRiBlock) {
        self.huanKuanRiBlock();
    }
}

// 获取验证码
- (void)codeAction:(UIButton *)sender{
    if (![NSString xhq_notEmpty:_yinHangView.textField.text tip:@"信用卡号"]) {
        return;
    }
    if (![NSString xhq_notEmpty:_CVN2View.textField.text tip:@"CVN2"]) {
        return;
    }
    if (![NSString xhq_notEmpty:_youXiaoQiView.textField.text tip:@"有效期"]) {
        return;
    }
    if (![NSString xhq_phoneFormatCheck:_phoneView.textField.text tip:@"预留手机号"]) {
        return;
    }
    if (self.codeBlock) {
        self.codeBlock(_yinHangView.textField.text,
                       _CVN2View.textField.text,
                       _youXiaoQiView.textField.text,
                       _phoneView.textField.text);
    }
}

// 添加信用卡
- (void)addCardAction:(UIButton *)sender{
    [self endEditing:YES];
    if (!_nameView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入真实姓名"];
    }else if (!_idcardView.textField.text.length){
        [DYShowView ShowWithText:@"请输入身份证号"];
    }else if (![Utils validateIdentityCard:_idcardView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的身份证号"];
    }else if (!_yinHangView.textField.text.length){
        [DYShowView ShowWithText:@"请输入信用卡号"];
    }else if (!_CVN2View.textField.text.length){
        [DYShowView ShowWithText:@"请输入信用卡背面三位CVN2"];
    }else if (_CVN2View.textField.text.length < 3 || _CVN2View.textField.text.length > 3){
        [DYShowView ShowWithText:@"请输入正确的信用卡背面三位CVN2"];
    }else if (!_youXiaoQiView.textField.text.length){
        [DYShowView ShowWithText:@"请选择信用卡有效期"];
    }else if (!_faYiHangView.textField.text.length){
        [DYShowView ShowWithText:@"请选择发卡银行"];
    }else if (!_zhangDanView.textField.text.length){
        [DYShowView ShowWithText:@"请选择账单日"];
    }else if (!_huanKuanView.textField.text.length){
        [DYShowView ShowWithText:@"请选择还款日"];
    }else if (!_phoneView.textField.text.length){
        [DYShowView ShowWithText:@"请输入银行预留手机号码"];
    }else if (![Utils validatePhone:_phoneView.textField.text]){
        [DYShowView ShowWithText:@"请输入正确的银行预留手机号码"];
    }
//    else if (!_codeView.textField.text.length){
//        [DYShowView ShowWithText:@"请输入验证码"];
//    }
    else{
        if (self.addBlock) {
            self.addBlock(_nameView.textField.text, _idcardView.textField.text, _yinHangView.textField.text, _CVN2View.textField.text, _youXiaoQiView.textField.text, _faYiHangView.textField.text, _zhangDanView.textField.text, _huanKuanView.textField.text, _phoneView.textField.text, _codeView.textField.text);
        }
    }
}

@end




#pragma mark ----------------- singleView
@implementation DYAddRepaymentSingleView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUIWithTitle:title placeHolder:placeHolder];
    }
    return self;
}

- (void)setupUIWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder{
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
        make.right.equalTo(self.mas_right).offset(BILIWIDTH(-10));
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
    
    _xiaLaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_xiaLaBtn setImage:kGetImage(@"xial_hk") forState:UIControlStateNormal];
    [self addSubview:_xiaLaBtn];
    [_xiaLaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(53), BILIHEIGHT(35)));
        make.right.equalTo(self.mas_right);
    }];
}

@end


@interface DYSelectedCardTermView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *yearString;
@property (nonatomic, strong) NSString *monthString;

@end

static CGFloat kTermTopHeight = 40;
static CGFloat kTermShowHeight = 240;

@implementation DYSelectedCardTermView

- (instancetype)init {
    if (self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)]) {
        self.monthString = @"01";
        self.yearString = [self getCurrentYear];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.showView];
    [self.showView addSubview:self.topView];
    [self.showView addSubview:self.pickerView];
    [self.topView addSubview:self.cancelButton];
    [self.topView addSubview:self.sureButton];
    [self.topView addSubview:self.titleLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(kTermShowHeight);
    }];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(0);
        make.height.equalTo(kTermTopHeight);
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView);
        make.left.equalTo(5);
        make.size.equalTo(CGSizeMake(60, 30));
    }];
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_topView);
        make.right.equalTo(-5);
        make.size.equalTo(CGSizeMake(60, 30));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_topView);
        make.left.lessThanOrEqualTo(_cancelButton.right);
        make.right.lessThanOrEqualTo(_sureButton.left);
    }];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.top.equalTo(_topView.bottom);
    }];
}

- (void)sureButtonClicked {
    if (self.monthString.length == 1) {
        self.monthString = [NSString stringWithFormat:@"0%@", self.monthString];
    }
    if (self.block) {
        self.block(self.yearString, self.monthString);
    }
    [self dismess];
}

- (void)cancelButtonClicked {
    [self dismess];
}

#pragma mark - public
- (void)pop {
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self];
    
    self.showView.transform = CGAffineTransformMakeTranslation(0, kTermShowHeight);
    [UIView animateWithDuration:0.3 animations:^{
        self.showView.transform = CGAffineTransformIdentity;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self]) {
        [self dismess];
    }
}

- (void)dismess {
    [UIView animateWithDuration:0.3 animations:^{
        self.showView.transform = CGAffineTransformMakeTranslation(0, kTermShowHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - getter
- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor whiteColor];
    }
    return _showView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = XHQHexColor(0xF1EDF6);
    }
    return _topView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:XHQHexColor(0x848484)
                                          font:XHQ_FONTBOLD(17)
                                          text:@"请选择有效期"];
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton xhq_buttonFrame:CGRectZero
                                          bgColor:[UIColor clearColor]
                                       titleColor:[UIColor grayColor]
                                      borderWidth:0
                                      borderColor:nil
                                     cornerRadius:0
                                              tag:0
                                           target:self
                                           action:@selector(cancelButtonClicked)
                                            title:@"取消"];
        _cancelButton.xhqFont = XHQ_FONT(17);
    }
    return _cancelButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor clearColor]
                                     titleColor:[UIColor xhq_base]
                                    borderWidth:0
                                    borderColor:nil
                                   cornerRadius:0
                                            tag:0
                                         target:self
                                         action:@selector(sureButtonClicked)
                                          title:@"确定"];
        _sureButton.xhqFont = XHQ_FONT(17);
    }
    return _sureButton;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

#pragma mark - UIPickerViewD

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return 12;
    }
    else {
        NSString *year = [self getCurrentYear];
        return 100 - [year integerValue];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%02ld月", row + 1];
    }else {
        NSString *year = [self getCurrentYear];
        return [NSString stringWithFormat:@"20%ld年", [year integerValue] + row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return kScreenWidth / 2.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIView* topLine  =  [pickerView.subviews objectAtIndex:1];
    UIView* botomLine  =  [pickerView.subviews objectAtIndex:2];
    topLine.backgroundColor = botomLine.backgroundColor = [UIColor xhq_base];
    CGFloat width = [self pickerView:self.pickerView widthForComponent:component];
    CGFloat rowheight =[self pickerView:self.pickerView rowHeightForComponent:(component)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, rowheight)];
    label.textAlignment = 1;
    label.font = XHQ_FONT(18);
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.monthString = [NSString stringWithFormat:@"%ld", row + 1];
    }else {
        self.yearString = [NSString stringWithFormat:@"%ld", [[self getCurrentYear] integerValue] + row];;
    }
}

- (NSString *)getCurrentYear {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *year = [dateFormatter stringFromDate:date];
    return [year substringFromIndex:2];
}

@end
