//
//  DYTextField.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTextField.h"

@interface DYTextField ()

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UIView *leftContainerView;
@property (nonatomic, strong) UIView *rightContainerView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIButton *timerButton;
@property (nonatomic, strong) UILabel *downLineLabel;

@end

@implementation DYTextField

- (instancetype)init {
    if (self = [super init]) {
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _leftViewWidth = BILIWIDTH(40);
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.font = [UIFont xhq_font14];
    self.layer.cornerRadius = BILIWIDTH(5);
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.downLineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_downLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.height.equalTo(0.7);
        make.left.equalTo(self.leftViewWidth);
    }];
}


#pragma mark - setter

- (void)setLeftImage:(UIImage *)leftImage {
    if (_leftImage != leftImage) {
        _leftImage = leftImage;
        self.leftView = self.leftContainerView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftImageView.image = leftImage;
        [self.leftContainerView addSubview:self.leftImageView];
        [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.leftContainerView);
        }];
    }
}

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
        self.leftView = self.leftContainerView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftTitleLabel.text = title;
        [self.leftContainerView addSubview:self.leftTitleLabel];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftContainerView);
            make.left.equalTo(BILIWIDTH(10));
        }];
    }
}

- (void)setLeftViewWidth:(CGFloat)leftViewWidth {
    if (_leftViewWidth != leftViewWidth) {
        _leftViewWidth = leftViewWidth;
        self.leftContainerView.xhq_width = leftViewWidth;
    }
}

- (void)setSubTitle:(NSString *)subTitle {
    if (_subTitle != subTitle) {
        _subTitle = subTitle;
        UILabel *titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_content]
                                                  font:[UIFont xhq_font12]
                                                  text:subTitle];
        titleLabel.frame = CGRectMake(0, 0, BILIWIDTH(20), BILIHEIGHT(45));
        self.rightView = titleLabel;
        self.rightViewMode = UITextFieldViewModeAlways;
    }
}

- (void)setShowTimerButton:(BOOL)showTimerButton {
    _showTimerButton = showTimerButton;
    if (showTimerButton) {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightView = self.timerButton;
    }
}

- (void)setShowClickSelectButton:(BOOL)showClickSelectButton {
    _showClickSelectButton = showClickSelectButton;
    if (showClickSelectButton) {
        self.rightViewMode = UITextFieldViewModeAlways;
        self.placeholder = @"-- 请选择 --";
        self.rightView = self.selectedButton;
    }
}

- (void)setShowDownLine:(BOOL)showDownLine {
    _showDownLine = showDownLine;
    self.downLineLabel.hidden = !showDownLine;
}

- (void)setDownLineColor:(UIColor *)downLineColor {
    if (_downLineColor != downLineColor) {
        _downLineColor = downLineColor;
        self.downLineLabel.backgroundColor = downLineColor;
    }
}


#pragma mark - getter

- (UIImageView *)leftImageView {
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc]init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftImageView;
}

- (UILabel *)leftTitleLabel {
    if (!_leftTitleLabel) {
        _leftTitleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                              font:self.font
                                              text:@""];
    }
    return _leftTitleLabel;
}

- (UIView *)leftContainerView {
    if (!_leftContainerView) {
        _leftContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BILIWIDTH(40), BILIHEIGHT(45))];
        _leftContainerView.backgroundColor = [UIColor clearColor];
    }
    return _leftContainerView;
}

- (UIView *)rightContainerView {
    if (!_rightContainerView) {
        _rightContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BILIWIDTH(45), BILIHEIGHT(45))];
        _rightContainerView.backgroundColor = [UIColor clearColor];
    }
    return _rightContainerView;
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedButton.frame = CGRectMake(0, 0, BILIWIDTH(45), BILIHEIGHT(45));
        [_selectedButton setImage:[UIImage imageNamed:@"f_downselect"] forState:UIControlStateNormal];
        [_selectedButton addTarget:self action:@selector(dy_textFieldRightClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

- (UIButton *)timerButton {
    if (!_timerButton) {
        _timerButton = [UIButton xhq_buttonFrame:CGRectMake(0, 0, BILIWIDTH(90), BILIHEIGHT(45))
                                         bgColor:[UIColor clearColor]
                                      titleColor:[UIColor xhq_base]
                                     borderWidth:0
                                     borderColor:nil
                                    cornerRadius:0
                                             tag:0
                                          target:self
                                          action:@selector(dy_textFieldRightClick)
                                           title:@"获取验证码"];
        _timerButton.titleLabel.font = [UIFont xhq_font12];
        [_timerButton addSubview:[self lineLabel]];
    }
    return _timerButton;
}

- (UILabel *)downLineLabel {
    if (!_downLineLabel) {
        _downLineLabel = [UILabel xhq_lineLabel];
    }
    return _downLineLabel;
}

- (UILabel *)lineLabel {
    return ({
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, BILIHEIGHT(12.5), 1, BILIHEIGHT(20))];
        label.backgroundColor = [UIColor xhq_base];
        label;
    });
}

- (void)dy_textFieldRightClick {
    if (self.block) {
        self.block();
    }
}

#pragma mark - public

- (void)countDown {
    if (!_timerButton) {
        return;
    }
    __block NSInteger time = 59;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0* NSEC_PER_SEC), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time <=0) {
            dispatch_source_cancel(timer);
            self.timerButton.enabled = YES;
            [self.timerButton setTitle:@"重新获取" forState:UIControlStateNormal];
            [self.timerButton setTitleColor:[UIColor xhq_base] forState:UIControlStateNormal];
            time = 59;
        }else {
            time --;
            self.timerButton.enabled = NO;
            NSString * str = [NSString stringWithFormat:@"剩余%ld秒",time + 1];
            [self.timerButton setTitle:str forState:UIControlStateNormal];
            [self.timerButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    });
    dispatch_resume(timer);
}

@end
