//
//  CXLRefreshNormalHeader.m
//  WeiMinJinFu
//
//  Created by 崔祥莉 on 2017/9/1.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "CXLRefreshNormalHeader.h"

@implementation CXLRefreshNormalHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 自动改变透明度
        self.automaticallyChangeAlpha = YES;
        
        // 设置各种状态下的刷新文字
        //        [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        //        [self setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
        //        [self setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
        // 设置颜色
        //        self.stateLabel.textColor = [UIColor grayColor];
        //        self.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
        //初始化时开始刷新
        //        [self beginRefreshing];
        
        
        self.stateLabel.font = kFont(12);
        self.lastUpdatedTimeLabel.font = kFont(12);
    }
    return self;
}

@end
