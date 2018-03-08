//
//  DYExtendListScreenView.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddRepaymentView.h"

@class DYExtendListScreenSingleView;

typedef void(^DYExtendListScreenViewTimeBlock)(BOOL isStar);
@interface DYExtendListScreenView : UIView

@property (nonatomic, strong) DYAddRepaymentSingleView *typeView;
@property (nonatomic, strong) DYExtendListScreenSingleView *startView;
@property (nonatomic, strong) DYExtendListScreenSingleView *endView;
@property (nonatomic, copy) DYExtendListScreenViewTimeBlock block;

@end

@interface DYExtendListScreenSingleView : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *lineLabel;
- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;

@end
