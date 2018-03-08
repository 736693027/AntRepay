//
//  DYSurePlanAlertView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYSurePlanAlertView : UIView

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, copy) void(^sureBlock)(void);

@end
