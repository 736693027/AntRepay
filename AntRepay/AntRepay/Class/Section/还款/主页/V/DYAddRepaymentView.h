//
//  DYAddRepaymentView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRepaymentModel.h"

@interface DYAddRepaymentSingleView : UIView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *xiaLaBtn; // 下拉按钮
@end

typedef void(^DYTermButtonBlock)(void);
typedef void(^DYIssuingBankCardBlock)(void);
@interface DYAddRepaymentView : UIView
@property (nonatomic, strong) DYAddRepaymentSingleView *nameView;
@property (nonatomic, strong) DYAddRepaymentSingleView *idcardView;
@property (nonatomic, strong) DYAddRepaymentSingleView *bankView;
@property (nonatomic, strong) DYAddRepaymentSingleView *CVN2View;
@property (nonatomic, strong) DYAddRepaymentSingleView *youXiaoQiView;
@property (nonatomic, strong) DYAddRepaymentSingleView *yinHangView;
@property (nonatomic, strong) DYAddRepaymentSingleView *faYiHangView;
@property (nonatomic, strong) DYAddRepaymentSingleView *zhangDanView;
@property (nonatomic, strong) DYAddRepaymentSingleView *huanKuanView;
@property (nonatomic, strong) DYAddRepaymentSingleView *phoneView;
@property (nonatomic, strong) DYAddRepaymentSingleView *codeView;
@property (nonatomic, strong) UIButton *codeBtn;

@property (nonatomic, copy) DYTermButtonBlock termBlock;
@property (nonatomic, copy) DYIssuingBankCardBlock issuingBlock;
@property (nonatomic, copy) void(^zhangDanRiBlock)(void);
@property (nonatomic, copy) void(^huanKuanRiBlock)(void);
@property (nonatomic, copy) void(^addBlock)(NSString *realName,NSString *idcard,NSString *yinhangka,NSString*CVN2,NSString *youXiaoQi,NSString *faKa,NSString *zhangDanQi,NSString *huanKuanQi,NSString *phone,NSString *code);   // 添加新银行卡
@property (nonatomic, copy) void(^codeBlock)(NSString *num, NSString *cvn2, NSString *date, NSString *phone); // 验证码

@property (nonatomic, strong) NSString *codeString;
@property (nonatomic, strong) DYRepaymentMemberModel *memberModel;

@end


typedef void(^DYSelectedCardTermViewBlock)(NSString *year, NSString *month);
@interface DYSelectedCardTermView : UIView

@property (nonatomic, copy) DYSelectedCardTermViewBlock block;

- (void)pop;

@end

