//
//  DYRepaymentPlanPageVC.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYPageController.h"


@interface DYRepaymentPlanPageVC : DYPageController

@property (nonatomic, assign) BOOL execution; /**<执行中的*/
@property (nonatomic, strong) NSString *card_id;

@end
