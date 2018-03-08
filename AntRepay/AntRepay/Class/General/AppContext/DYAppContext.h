//
//  DYAppContext.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DYModel.h"

@class DYAppUser;

@interface DYAppContext : NSObject

@property (nonatomic, strong) DYAppUser *appUser;
@property (nonatomic, assign) BOOL isLogin;


XHQ_SHARED_H(DYAppContext);


/**
 检查登录状态
 */
- (void)checkLogin;


/**
 登录成功
 @param info 成功的数据 <phone, id, nick_name>
 */
- (void)loginSuccess:(NSDictionary *)info;


/**
 刷新用户数据与状态
 @param completion 成功后回调
 */
- (void)reloadUserInfoCompletion:(void (^)(void))completion;


/**
 弹出登录页面

 @param currentVC 当前控制器
 @param completion 回调
 */
- (void)showLoginInViewController:(UIViewController *)currentVC
                       completion:(void (^)(void))completion;

@end



@interface DYAppUser : DYModel

/**
 头像
 */
@property (nonatomic, strong) NSString *avatar;

/**
 真实姓名
 */
@property (nonatomic, strong) NSString *realname;

/**
 身份证号
 */
@property (nonatomic, strong) NSString *idcard;

/**
 昵称
 */
@property (nonatomic, strong) NSString *nickname;

/**
 手机号
 */
@property (nonatomic, strong) NSString *phone;

/**
 性别
 */
@property (nonatomic, strong) NSString *sex;


/**
 1-业务员，0-用户
 */
@property (nonatomic, strong) NSString *is_worker;


/**
 是否有使用权 1-已购买，0-未购买
 */
@property (nonatomic, strong) NSString *is_pay;


/** 
 是否绑定储蓄卡 1-已绑定，0-未绑定
 */
@property (nonatomic, strong) NSString *cash_bank;

@end


