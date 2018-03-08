//
//  DYMessageCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMessageModel.h"

@interface DYMessageCell : UITableViewCell

// 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView;

// 高度
+(CGFloat)cellHeight;

// 赋值
-(void)setValueWithModel:(DYMessageModel *)model;

@end
