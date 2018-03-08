//
//  DYChangeAlertView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYChangeAlertView : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, copy) void(^changeZiLiaoBlock)(void);
@property (nonatomic, copy) void(^deleteBankBlock)(void);
@property (nonatomic, copy) void(^deleteXiaoFeiBlock)(void);
@property (nonatomic, copy) void(^planJieDongBlock)(void);
@property (nonatomic, copy) void(^DonePlanBlock)(void);
@end
