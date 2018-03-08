//
//  DYInvitationAuthenticationVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/11.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYInvitationAuthenticationVC.h"
#import "DYAddRepaymentView.h"
#import "DYIdentityAuthVC.h"

@interface DYInvitationAuthenticationVC ()

@property (nonatomic, strong) DYAddRepaymentSingleView *codeView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *nextButton; // 保存按钮

@end

@implementation DYInvitationAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"激活码认证";
}

- (void)dy_initUI {
    [super dy_initUI];
    
    [self.view addSubview:self.codeView];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.nextButton];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeView.bottom).offset(BILIHEIGHT(20));
        make.left.equalTo(BILIWIDTH(15));
        make.right.equalTo(BILIWIDTH(-15));
    }];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLabel.bottom).offset(BILIHEIGHT(30));
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

- (void)nextButtonClicked {
    if (![NSString xhq_notEmpty:_codeView.textField.text tip:@"激活码"]) {
        return;
    }
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"code": _codeView.textField.text
                            };
    XHQHUDSHOW(self.view);
    [DYAppReq POST:_url_verify_coed param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                DYIdentityAuthVC *vc = [[DYIdentityAuthVC alloc]init];
                PUSHVC(vc);
            }else {
                XHQHUDMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - getter

- (DYAddRepaymentSingleView *)codeView {
    if (!_codeView) {
        _codeView = [[DYAddRepaymentSingleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(67))
                                                             title:@"激活码"
                                                       placeHolder:@"请填写您的激活码"];
        _codeView.xiaLaBtn.hidden = YES;
    }
    return _codeView;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor xhq_base]
                                     titleColor:[UIColor whiteColor]
                                    borderWidth:0
                                    borderColor:nil
                                   cornerRadius:5
                                            tag:0
                                         target:self
                                         action:@selector(nextButtonClicked)
                                          title:@"下一步"];
        _nextButton.xhqFont = [UIFont xhq_font14];
    }
    return _nextButton;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        NSString *txt = @"温馨提示：\n1、若您之前有填写过激活码，请重新输入即可。\n2、若未持有激活码，购买激活码请联系相关人员。\n3、激活码一经认证，不允许其他账户再次使用!";
        _tipLabel = [UILabel xhq_layoutColor:[UIColor xhq_content]
                                        font:XHQ_FONT(13)
                                        text:txt];
        _tipLabel.numberOfLines = 0;
        _tipLabel.preferredMaxLayoutWidth = kScreenWidth - BILIWIDTH(30);
        [_tipLabel paragraphSpace:3];
    }
    return _tipLabel;
}

@end
