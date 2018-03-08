//
//  DYTabBarController.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTabBarController : UITabBarController

- (void)addChildViewControllerClassName:(NSString *)className
                                  title:(NSString *)title
                              imageName:(NSString *)imageName;

@end
