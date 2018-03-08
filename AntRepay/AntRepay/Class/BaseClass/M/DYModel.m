//
//  DYModel.m
//  Excellence
//
//  Created by 帝云科技 on 2017/7/4.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@implementation DYModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

+ (instancetype)model {
    return [[self alloc] init];
}

@end
