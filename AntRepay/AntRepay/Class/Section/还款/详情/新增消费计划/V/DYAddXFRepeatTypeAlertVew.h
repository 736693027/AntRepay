//
//  DYAddXFRepeatTypeAlertVew.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYAddXFRepeatTypeAlertVew : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *dayBtn;
@property (nonatomic, strong) UIButton *weekBtn;
@property (nonatomic, strong) UIButton *monthBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *lineLabel1;
@property (nonatomic, strong) UILabel *lineLabel2;

@property (nonatomic, copy) void(^dayBlock)(NSString *day);
@property (nonatomic, copy) void(^weekBlock)(NSString *week);
@property (nonatomic, copy) void(^monthBlock)(NSString *month);

- (void)hide;
@end
