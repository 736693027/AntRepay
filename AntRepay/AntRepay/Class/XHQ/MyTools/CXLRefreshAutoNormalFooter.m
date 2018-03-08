//
//  CXLRefreshAutoNormalFooter.m
//  WeiMinJinFu
//
//  Created by 崔祥莉 on 2017/9/1.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "CXLRefreshAutoNormalFooter.h"

@implementation CXLRefreshAutoNormalFooter

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 自动改变透明副
//        self.automaticallyChangeAlpha = YES;
//
        self.stateLabel.font = kFont(12);
    }
    return self;
}

@end
