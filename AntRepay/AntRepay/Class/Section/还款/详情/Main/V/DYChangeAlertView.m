//
//  DYChangeAlertView.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYChangeAlertView.h"


@implementation DYChangeAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self addSubview:_backView];
    _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    _imgView.image = kGetImage(@"beij_blt");
    _imgView.clipsToBounds = YES;
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(113), BILIHEIGHT(134)));
        make.left.equalTo(self.mas_left).offset(BILIWIDTH(250));
        make.top.equalTo(self.mas_top).offset(BILIHEIGHT(50));
    }];
    _imgView.userInteractionEnabled = YES;
    
    NSArray *arr = @[@{@"img":@"xiug_hk",@"title":@"修改资料"},
                     @{@"img":@"xiug_hk",@"title":@"删除银行卡"},
//                     @{@"img":@"dele",@"title":@"删除消费"},
                     @{@"img":@"jied_hk",@"title":@"计划解冻"},
                     @{@"img":@"zhixing",@"title":@"已执行计划"}];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imgView addSubview:button];
        [button setTitle:arr[i][@"title"] forState:UIControlStateNormal];
        [button setImage:kGetImage(arr[i][@"img"]) forState:UIControlStateNormal];
        button.titleLabel.font = kFont(14);
        [button.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.mas_left).offset(BILIWIDTH(5));
            make.centerY.equalTo(button.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(BILIWIDTH(15), BILIHEIGHT(16)));
        }];
        [button.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(button.imageView.mas_right).offset(BILIWIDTH(20));
            make.centerY.equalTo(button.mas_centerY);
        }];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, BILIWIDTH(10), 0, 0)];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(BILIWIDTH(113), BILIHEIGHT(30.6)));
            make.top.equalTo(_imgView.mas_top).offset(BILIHEIGHT(7)+BILIHEIGHT(30.6)*i);
            make.left.equalTo(_imgView.mas_left);
        }];
        button.tag = 10+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

// 按钮点击
- (void)buttonClick:(UIButton *)sender{
    if (sender.tag == 10) {
        if (self.changeZiLiaoBlock) {
            self.changeZiLiaoBlock();
        }
    }else if (sender.tag == 11){
        if (self.deleteBankBlock) {
            self.deleteBankBlock();
        }
    }
//    else if (sender.tag == 12){
//        if (self.deleteXiaoFeiBlock) {
//            self.deleteXiaoFeiBlock();
//        }
//    }
    else if (sender.tag == 12){
        if (self.planJieDongBlock) {
            self.planJieDongBlock();
        }
    }else if (sender.tag == 13){
        if (self.DonePlanBlock) {
            self.DonePlanBlock();
        }
    }
    [self hide];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self hide];
}

-(void)hide{
    [UIView animateWithDuration:0.2 animations:^{
//        _imgView.frame = CGRectMake(BILIWIDTH(250), BILIHEIGHT(50), BILIWIDTH(113), 0);
    } completion:^(BOOL finished) {
        [_imgView removeFromSuperview];
        _backView.backgroundColor = KClearColor;
        [self removeFromSuperview];
    }];
}

@end
