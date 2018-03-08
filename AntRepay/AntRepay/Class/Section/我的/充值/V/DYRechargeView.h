//
//  DYRechargeView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddRepaymentView.h"

typedef void(^DYRechargeViewTermBlock)(void);
@interface DYRechargeView : UIView
@property (nonatomic, strong) UILabel *yuLabel; // 账户余额
@property (nonatomic, strong) UIButton *codeBtn;
@property (nonatomic, strong) DYAddRepaymentSingleView *youXiaoQiView;

@property (nonatomic, copy) DYRechargeViewTermBlock termBlock;
@property (nonatomic, copy) void(^codeBlock)(NSString *phone); // 验证码
@property (nonatomic, copy) void(^rechargeBlock)(NSString *money,NSString *kaHao,NSString *CVN2,NSString *youXiaoQi,NSString *phone,NSString *code);

@end

