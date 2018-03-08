//
//  DYNickNameVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYNickNameVC.h"
#import "DYAddRepaymentView.h"

@interface DYNickNameVC ()
@property (nonatomic, strong) DYAddRepaymentSingleView *nickView;
@property (nonatomic, strong) UIButton *saveBtn; // 保存按钮
@end

@implementation DYNickNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"昵称";
    _nickView = [[DYAddRepaymentSingleView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(67)) title:@"昵称" placeHolder:@"请设置您的昵称"];
    [self.view addSubview:_nickView];
    _nickView.xiaLaBtn.hidden = YES;
    
    _saveBtn = [Utils createBtnWithType:UIButtonTypeCustom backgroundColor:[UIColor xhq_base] action:@selector(saveAction:) target:self title:@"保存" image:nil font:14 textColor:KWhiteColor];
    [self.view addSubview:_saveBtn];
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(BILIHEIGHT(116));
    }];
    ViewRadius(_saveBtn, BILIHEIGHT(5));
}

// 保存
- (void)saveAction:(UIButton *)sender{
    if (!_nickView.textField.text.length) {
        [DYShowView ShowWithText:@"请输入您的昵称"];
    }else{
        [self requestData];
    }
}

// 请求保存昵称数据
- (void)requestData{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ,
                             @"nickname":_nickView.textField.text
                             };
    [DYAppReq GET:_url_basic_nick param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDTEXT(@"修改成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
