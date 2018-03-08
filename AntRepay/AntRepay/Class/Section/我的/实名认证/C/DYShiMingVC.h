//
//  DYShiMingVC.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"

@interface DYShiMingVC : DYViewController

@end



@interface DYAreaListModel : DYModel

@property (nonatomic, strong) NSString *name;

@end

@interface DYBankNameModel : DYModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *number;

@end
