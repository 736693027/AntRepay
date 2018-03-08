//
//  DYTabBarController.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTabBarController.h"
#import "DYNavigationController.h"
#import "DYLoginVC.h"


@interface DYTabBarController ()<
UITabBarControllerDelegate>

@end

static NSString *const _image_highlighted = @"_highlighted";

static NSString *const _image_tabbar_home = @"tabbar_home";
static NSString *const _image_tabbar_repayment = @"tabbar_repayment";
static NSString *const _image_tabbar_books = @"tabbar_books";
static NSString *const _image_tabbar_account = @"tabbar_account";

static NSString *const _tabbar_vc_1 = @"DYHomePageVC";
static NSString *const _tabbar_vc_2 = @"DYRepaymentVC";
static NSString *const _tabbar_vc_3 = @"DYBooksVC";
static NSString *const _tabbar_vc_4 = @"DYAccountVC";

static NSString *const _tabbar_title_1 = @"首页";
static NSString *const _tabbar_title_2 = @"蚂蚁还款";
static NSString *const _tabbar_title_3 = @"交易明细";
static NSString *const _tabbar_title_4 = @"个人中心";

@implementation DYTabBarController

+ (void)initialize {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor xhq_hexb7];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor xhq_base];
    
    UITabBarItem *items = [UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewControllers];
    self.delegate = self;
}

- (void)addChildViewControllers {
    [self addChildViewControllerClassName:_tabbar_vc_1 title:@"首页" imageName:_image_tabbar_home];
    [self addChildViewControllerClassName:_tabbar_vc_2 title:@"蚂蚁还款" imageName:_image_tabbar_repayment];
    [self addChildViewControllerClassName:_tabbar_vc_3 title:@"交易明细" imageName:_image_tabbar_books];
    [self addChildViewControllerClassName:_tabbar_vc_4 title:@"个人中心" imageName:_image_tabbar_account];
}

- (void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName {
    
    UIViewController *viewController = [[NSClassFromString(className) alloc]init];
    viewController.tabBarItem.title = title;
    DYNavigationController *nav = [[DYNavigationController alloc]initWithRootViewController:viewController];
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor xhq_section];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:_image_highlighted]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSInteger selectedIndex = [tabBarController.viewControllers indexOfObject:viewController];
    BOOL isLogin = [[DYAppContext sharedDYAppContext] isLogin];
    if (selectedIndex != 0 && !isLogin) {
        [[DYAppContext sharedDYAppContext] showLoginInViewController:self completion:nil];
        return NO;
    }
    return YES;
}

@end
