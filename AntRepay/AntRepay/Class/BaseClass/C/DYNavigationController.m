//
//  DYNavigationController.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYNavigationController.h"

@interface DYNavigationController ()<
UINavigationControllerDelegate>

@end

@implementation DYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self initNavigation];
}

- (void)initNavigation {
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor xhq_aTitle],
                                     NSFontAttributeName: [UIFont xhq_font18]}];
    [navBar setBarTintColor:[UIColor whiteColor]];
    navBar.opaque = NO;
    navBar.translucent = NO;
    [[UIBarButtonItem appearance] setTintColor:[UIColor xhq_aTitle]];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (self.viewControllers.count > 0 && !viewController.navigationItem.leftBarButtonItem) {
//        viewController.navigationItem.leftBarButtonItems = [self backButtonItems];
        viewController.navigationItem.leftBarButtonItem = [self backButtonItem];
    }
    [super pushViewController:viewController animated:animated];
}

- (NSArray *)backButtonItems {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, BILIWIDTH(20), 40)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    space.width = BILIWIDTH(-30);
    
    return @[space, backItem];
}

- (UIBarButtonItem *)backButtonItem {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"]
                                            style:UIBarButtonItemStylePlain
                                           target:self
                                           action:@selector(back)];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
