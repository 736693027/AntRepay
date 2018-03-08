//
//  DYHomeWebVC.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/27.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"

typedef NS_ENUM(NSInteger, webType) {
    webTypeApplyLoan = 0, /**<申请贷款*/
    webTypeApplyCard, /**<申请信用卡*/
    webTypeCardPorgress /**<信用卡进度*/
};
@interface DYHomeWebVC : DYViewController

@property (nonatomic, assign) webType type;

@end
