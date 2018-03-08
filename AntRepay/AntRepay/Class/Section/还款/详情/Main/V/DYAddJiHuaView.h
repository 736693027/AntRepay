//
//  DYAddJiHuaView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYAddJiHuaView : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *xiaoFeiBtn;
@property (nonatomic, strong) UIButton *huanKuanBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, copy) void(^xiaoFeiPlanBlock)(void);
@property (nonatomic, copy) void(^huanKuanPlanBlock)(void);

- (void)hide;
@end
