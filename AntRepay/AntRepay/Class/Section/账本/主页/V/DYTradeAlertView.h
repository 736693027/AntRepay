//
//  DYTradeAlertView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTradeAlertView : UIView
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, copy) void(^selectedBlock)(NSString *type,NSInteger tag);
@property (nonatomic, copy) void(^cancelBlock)(void);
@property (nonatomic, strong) NSArray *typeArray;

- (void)pop;
- (void)hide;

@end
