//
//  DYShareView.m
//  Julong
//
//  Created by 帝云科技 on 2017/8/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYShareView.h"

@interface DYShareView ()

@property (nonatomic, strong) UIView *showView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) DYShareSelectedItem *QQItem;
@property (nonatomic, strong) DYShareSelectedItem *WechatItem;
@property (nonatomic, strong) DYShareSelectedItem *CircleItem;

@property (nonatomic, copy) DYShareViewHandle block;

@end

static NSString *const _image_share_qq = @"share_qq";
static NSString *const _image_share_circle = @"share_circle";
static NSString *const _image_share_wechat = @"share_wechat";

@implementation DYShareView

+ (void)shareSelectCompletion:(DYShareViewHandle)completion {
    DYShareView *share = [[DYShareView alloc]init];
    share.block = completion;
    [share pop];
}

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.backgroundColor = XHQRGBA(0, 0, 0, 0.3);
        [self initUI];
    }
    return self;
}


- (void)initUI {
    [self addSubview:self.showView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_showView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(BILIHEIGHT(200));
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(BILIHEIGHT(-20));
        make.centerX.equalTo(_showView);
        make.size.equalTo(CGSizeMake(BILIWIDTH(345), BILIHEIGHT(40)));
    }];
    [_CircleItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_showView);
        make.top.equalTo(BILIHEIGHT(20));
        make.size.equalTo(CGSizeMake(BILIWIDTH(60), BILIHEIGHT(80)));
    }];
    [_WechatItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(_CircleItem);
        make.right.equalTo(_CircleItem.left).offset(BILIWIDTH(-50));
    }];
    [_QQItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.top.equalTo(_CircleItem);
        make.left.equalTo(_CircleItem.right).offset(BILIWIDTH(50));
    }];
    
}

- (void)pop {
    UIWindow *keyWindow = [UIApplication sharedApplication].delegate.window;
    [keyWindow addSubview:self];
    self.showView.transform = CGAffineTransformMakeTranslation(0, BILIHEIGHT(200));
    [UIView animateWithDuration:0.3 animations:^{
        self.showView.transform = CGAffineTransformIdentity;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self]) {
        [self dismiss];
    }
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.showView.transform = CGAffineTransformMakeTranslation(0, BILIHEIGHT(200));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)cancelClick {
    [self dismiss];
}

- (void)operationButtonClick:(UITapGestureRecognizer *)sender {
    DYShareType type = DYShareQQ;
    if (sender.view == _QQItem) {
        type = DYShareQQ;
    }
    else if (sender.view == _WechatItem) {
        type = DYShareWechat;
    }
    else if (sender.view == _CircleItem) {
        type = DYShareCircle;
    }
    if (self.block) {
        self.block(type);
    }
    [self dismiss];
}

#pragma mark - getter

- (UIView *)showView {
    if (!_showView) {
        _showView = [[UIView alloc]init];
        _showView.backgroundColor = [UIColor whiteColor];
        [_showView addSubview:self.cancelButton];
        [_showView addSubview:self.QQItem];
        [_showView addSubview:self.WechatItem];
        [_showView addSubview:self.CircleItem];
    }
    return _showView;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton xhq_buttonFrame:CGRectZero
                                          bgColor:[UIColor xhq_hexb7]
                                       titleColor:[UIColor whiteColor]
                                      borderWidth:0
                                      borderColor:nil
                                     cornerRadius:5
                                              tag:0
                                           target:self
                                           action:@selector(cancelClick)
                                            title:@"取消"];
        _cancelButton.xhqFont = [UIFont xhq_font14];
    }
    return _cancelButton;
}

- (DYShareSelectedItem *)QQItem {
    if (!_QQItem) {
        _QQItem = [[DYShareSelectedItem alloc]init];
        _QQItem.titleLabel.text = @"QQ";
        _QQItem.imageView.image = [UIImage imageNamed:_image_share_qq];
        [_QQItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonClick:)]];
    }
    return _QQItem;
}

- (DYShareSelectedItem *)CircleItem {
    if (!_CircleItem) {
        _CircleItem = [[DYShareSelectedItem alloc]init];
        _CircleItem.titleLabel.text = @"朋友圈";
        _CircleItem.imageView.image = [UIImage imageNamed:_image_share_circle];
        [_CircleItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonClick:)]];
    }
    return _CircleItem;
}

- (DYShareSelectedItem *)WechatItem {
    if (!_WechatItem) {
        _WechatItem = [[DYShareSelectedItem alloc]init];
        _WechatItem.titleLabel.text = @"微信";
        _WechatItem.imageView.image = [UIImage imageNamed:_image_share_wechat];
        [_WechatItem addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(operationButtonClick:)]];
    }
    return _WechatItem;
}

@end

@interface DYShareSelectedItem ()

@end

@implementation DYShareSelectedItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    self.userInteractionEnabled = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(BILIHEIGHT(10));
        make.size.equalTo(CGSizeMake(BILIWIDTH(40), BILIHEIGHT(40)));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_imageView.bottom).offset(BILIHEIGHT(10));
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [_imageView xhq_setAspectFitContentMode];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font16]
                                          text:@""];
    }
    return _titleLabel;
}

@end
