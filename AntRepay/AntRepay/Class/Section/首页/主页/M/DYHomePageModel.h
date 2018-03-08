//
//  DYHomePageModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYHomePageModel : DYModel

@end

@interface DYHomePageBannerModel : DYModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *image;

@end

@interface DYHomePageNoticeModel : DYModel
@property (nonatomic, strong) NSString *title;
@end
