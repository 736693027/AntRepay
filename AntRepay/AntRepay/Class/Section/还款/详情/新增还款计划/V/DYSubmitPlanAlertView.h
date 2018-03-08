//
//  DYSubmitPlanAlertView.h
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/3.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYAddRepaymentSubmitModel;

typedef void(^DYSubmitPlanAlertViewBlock)(void);

@interface DYSubmitPlanAlertView : UIView

@property (nonatomic, strong) DYAddRepaymentSubmitModel *submitModel;

@property (nonatomic, copy) DYSubmitPlanAlertViewBlock block;

- (void)pop;

@end
