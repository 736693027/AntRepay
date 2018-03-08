//
//  DYChangeCardView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddRepaymentView.h"

typedef void(^DYTermButtonBlock)(void);
@interface DYChangeCardView : UIView

@property (nonatomic, strong) DYAddRepaymentSingleView *zhangDanView;
@property (nonatomic, strong) DYAddRepaymentSingleView *huanKuanView;
@property (nonatomic, strong) DYAddRepaymentSingleView *cardNumView;
@property (nonatomic, strong) DYAddRepaymentSingleView *youXiaoQiView;

@property (nonatomic, copy) void(^zhangDanRiBlock)(void);
@property (nonatomic, copy) void(^huanKuanRiBlock)(void);
@property (nonatomic, copy) DYTermButtonBlock termBlock;

@property (nonatomic, copy) void(^changeBlock)(NSString *idcard,NSString*CVN2,NSString *youXiaoQi,NSString *zhangDanQi,NSString *huanKuanQi);   // 修改新银行卡
@end
