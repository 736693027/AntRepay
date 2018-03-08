//
//  DYBankAddVC.h
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/2.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYTableViewController.h"

typedef void(^DYBankAddVCBlock)(void);
@interface DYBankAddVC : DYTableViewController

@property (nonatomic, assign, getter=isEdit) BOOL edit;

@property (nonatomic, copy) DYBankAddVCBlock block;

@end
