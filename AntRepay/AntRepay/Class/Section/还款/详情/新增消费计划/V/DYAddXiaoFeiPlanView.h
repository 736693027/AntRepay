//
//  DYAddXiaoFeiPlanView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddRepaymentView.h"
#import "DYAddPayPlanModel.h"

/** single view **/
@interface DYAddXiaoFeiSinglePlanView : UIView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder image:(NSString *)image;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIButton *button;

@end



@interface DYAddXiaoFeiPlanView : UIView


@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *startTimeView;
@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *endTimeView;
@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *repeatTypeView;
@property (nonatomic, strong) DYAddXiaoFeiSinglePlanView *repeatContentView;
@property (nonatomic, strong) DYAddRepaymentSingleView *consumeView; // 消费金额

@property (nonatomic, strong) DYAddPayPlanModel *payModel;

@property (nonatomic, copy) void(^startTimeBlock)(NSString *time);
@property (nonatomic, copy) void(^endTimeBlock)(NSString *time);
@property (nonatomic, copy) void(^repeatTypeBlock)(NSString *repeatType);
@property (nonatomic, copy) void(^repeatContentBlock)(NSString *repeatContent);
@property (nonatomic, copy) void(^planYuLanBlock)(void);

@end
