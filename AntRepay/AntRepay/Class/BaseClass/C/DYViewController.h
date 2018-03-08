//
//  DYViewController.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYViewController : UIViewController

/**
 第一次进入控制器
 */
@property (nonatomic, assign) BOOL firstEnterController;

/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
 初始化数据
 */
- (void)dy_initData;

/**
 初始化控件
 */
- (void)dy_initUI;

/**
 数据请求
 */
- (void)dy_request;

/**
 viewwillappear调用
 */
- (void)dy_reloadData;


/**
 第一次进入控制器hud带背景
 */
- (void)dy_HUDBGShow;

@end
