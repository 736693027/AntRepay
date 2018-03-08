//
//  DYMyExtendVC.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"

typedef NS_ENUM(NSInteger, DYExtendType) {
    DYExtendTypeUser = 0, /**<用户*/
    DYExtendTypeSalesman, /**<业务员*/
};

@interface DYMyExtendVC : DYViewController

@property (nonatomic, assign) DYExtendType type;

@end
