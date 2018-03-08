//
//  DYAppContext.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAppContext.h"
#import "DYNavigationController.h"
#import "DYLoginVC.h"

@interface DYAppContext ()

@property (nonatomic, strong) NSString *appKey;
@property (nonatomic, strong) NSString *appName;

@end

@implementation DYAppContext

XHQ_SHARED_M(DYAppContext);

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initApp];
    }
    return self;
}

- (void)initApp {
    self.appUser = [[DYAppUser alloc]init];
    self.appKey = nil;
    self.appName = nil;
}

#pragma mark - setter
- (void)setIsLogin:(BOOL)isLogin {
    _isLogin = isLogin;
    if (_isLogin) {
        [self saveUserInfo];
    }
    else {
        [self cleanUserInfo];
    }
}

- (void)saveUserInfo {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.appKey forKey:DY_APP_KEY];
//    [ud setObject:self.appName forKey:DY_APP_USER_NAME];
    [ud synchronize];
}

- (void)cleanUserInfo {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:DY_APP_KEY];
    [ud removeObjectForKey:DY_APP_USER_PASS];
    [ud removeObjectForKey:DY_APP_PREVIOUS_PAGE];
    [ud synchronize];
}


#pragma mark - public
#pragma mark - 检测登录状态
- (void)checkLogin {
    _isLogin = [NSString xhq_notEmpty:DY_APP_KEY_VALUE];
    if (_isLogin) {
        [self reLogin];
    }
}

#pragma mark - 重新登录(每次重新打开app都需要执行此操作)
- (void)reLogin {
    NSString *phone = DY_APP_USER_NAME_VALUE;
    NSString *pass = DY_APP_USER_PASS_VALUE;
    NSDictionary *param = @{
                            @"phone": phone,
                            @"pass": pass
                            };
    [DYAppReq POST:_url_login param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"info"];
                [self loginSuccess:info];
            }else {
                [self showLoginVC];
            }
        }
    }];
}

#pragma mark - 登录成功
- (void)loginSuccess:(NSDictionary *)info {
    self.appName = info[@"phone"];
    self.appKey = info[@"id"];
    self.isLogin = YES;
    
    [self reloadUserInfoCompletion:nil];
}

#pragma mark - 更新用户信息
- (void)reloadUserInfoCompletion:(void (^)(void))completion {
    if (!_isLogin) return;
    
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_basic_data param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *info = responseObject[@"money"];
                self.appUser = [DYAppUser mj_objectWithKeyValues:info];
                if (completion) {
                    completion();
                }
                XHQ_Log(@"\n-- >>  用户信息更新成功  << --\n");
            }else {
                XHQ_Log(@"\n-- >>  用户信息更新失败  << --\n");
            }
        }else {
            XHQ_Log(@"\n-- >>  网络错误，用户信息更新失败  << --\n");
        }
    }];
}

#pragma mark - 登录失败，重新登录
- (void)showLoginVC {
    self.isLogin = NO;
    NSString *msg = @"账号已过期，请重新登录!";
    UIViewController *vc = [self getCurrentVC];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定"
                                                     style:UIAlertActionStyleDestructive
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       [self showLoginInViewController:vc
                                                                            completion:^{
                                                                                [self showRootVC:vc];
                                                                            }];
                                                   }];
    [alert addAction:action];
    [vc presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 弹出登录页面后 主控制器展示位首页
- (void)showRootVC:(UIViewController *)vc {
    UINavigationController *nav = (UINavigationController *)vc;
    [nav.navigationController popToRootViewControllerAnimated:YES];
    nav.tabBarController.selectedViewController = [vc.tabBarController.viewControllers objectAtIndex:0];
}

#pragma mark - 弹出登录页面
- (void)showLoginInViewController:(UIViewController *)currentVC completion:(void (^)(void))completion {
    DYLoginVC *login = [[DYLoginVC alloc]init];
    DYNavigationController *navLogin = [[DYNavigationController alloc]initWithRootViewController:login];
    [currentVC presentViewController:navLogin animated:YES completion:completion];
}

#pragma mark - 获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


@end


@implementation DYAppUser

@end
