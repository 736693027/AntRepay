//
//  DYWeekAlertView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYWeekAlertView : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, copy) void(^sureBlock)(NSString *weekStr,NSString *weekChuanStr);

- (void)hide;
@end
