//
//  DYBooksModel.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBooksModel.h"

@implementation DYBooksModel

@end

@implementation DYBooksTypeModel

@end

@implementation DYBooksMonthModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"order": [DYBooksListModel class]};
}

@end

@implementation DYBooksListModel

@end

@implementation DYBooksDetailModel

@end
