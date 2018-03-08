//
//  DYTiXianView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTiXianView : UIView

@property (nonatomic, strong) UILabel *yuLabel; // 账户余额
@property (nonatomic, copy) void(^tiXianBlock)(NSString *); // 提现

- (void)setValueWithModel:(NSDictionary *)model;

@end
