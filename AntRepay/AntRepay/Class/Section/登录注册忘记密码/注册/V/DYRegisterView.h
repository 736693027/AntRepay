//
//  DYRegisterView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYLoginSingleView.h"

@interface DYRegisterView : UIView
@property (nonatomic, strong) UIButton *codeBtn; // 验证码按钮
@property (nonatomic, copy) void(^codeBlock)(NSString *);
@property (nonatomic,copy)void (^registerBlock)(NSString *phone,NSString *password, NSString *codeNumber, NSString *inviterPhone); // 用户注册事件
@property (nonatomic, copy) void(^protocolBlock)(void);
@end
