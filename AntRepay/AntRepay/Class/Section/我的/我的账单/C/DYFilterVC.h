//
//  DYFilterVC.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"

@interface DYFilterVC : DYViewController

@property (nonatomic, copy) void(^filterBlock)(NSString *type,NSString *start_time,NSString *end_time);
@property (nonatomic, strong) NSArray *typeArray;

@end
