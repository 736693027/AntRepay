//
//  DYMineZhangDanModel.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DYMineZhangDanModel : NSObject
@property (nonatomic, strong) NSString *mId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *money;
@end

@interface DYMineZhangDanTypeModel : DYModel

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *value;

@end
