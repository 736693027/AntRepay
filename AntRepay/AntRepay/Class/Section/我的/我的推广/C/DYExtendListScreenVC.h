//
//  DYExtendListScreenVC.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTableViewController.h"

typedef void(^DYExtendListScreenVCBlock)(NSString *phone, NSString *start, NSString *end);
@interface DYExtendListScreenVC : DYViewController

@property (nonatomic, copy) DYExtendListScreenVCBlock block;

@end
