//
//  DYForgetPwdView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYForgetPwdView : UIView
@property (nonatomic, strong) UIButton *codeBtn; // 验证码按钮
@property (nonatomic, copy) void(^codeBlock)(NSString *phone);
@property (nonatomic, copy) void(^saveBlock)(NSString *phone,NSString *code,NSString *freshPwd, NSString *reFreshPwd);

@end
