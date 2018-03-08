//
//  DYExtendModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYExtendModel : DYModel

@property (nonatomic, strong) NSString *qrcode;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSArray *list;

@end


@interface DYExtendListModel : DYModel

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *add_time;
@property (nonatomic, strong) NSString *realname;

@end
