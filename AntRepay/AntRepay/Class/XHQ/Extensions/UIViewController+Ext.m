//
//  UIViewController+Ext.m
//  ShangDuHuiProject
//
//  Created by 帝云科技 on 2017/11/7.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)

- (void)xhq_popToViewControllerWithIndex:(NSInteger)aIndex {
    NSArray *arrController = [self.navigationController viewControllers];
    if (arrController.count >= aIndex) {
        [self.navigationController popToViewController:arrController[arrController.count - aIndex] animated:YES];
    }
}

@end
