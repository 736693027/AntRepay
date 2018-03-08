//
//  DYViewController.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "DYViewController+PVStatistics.h"

@interface DYViewController ()

@end

@implementation DYViewController

- (void)dealloc {
    NSLog(@"dealloc: %@", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self dy_initData];
    
    [self dy_initUI];
    
    [self dy_request];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dy_reloadData];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self pv_willAppear];
//    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [self pv_willDisappear];
//    });
}

- (void)dy_initData {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.firstEnterController = YES;
}

- (void)dy_initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dy_request{}


- (void)dy_reloadData{}

- (void)dy_HUDBGShow {
    if (self.firstEnterController) {
        self.firstEnterController = !self.firstEnterController;
        XHQHUDBGSHOW(self.view);
    }
    else {
        XHQHUDSHOW(self.view);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - getter

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

@end
