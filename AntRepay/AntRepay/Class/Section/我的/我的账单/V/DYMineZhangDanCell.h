//
//  DYMineZhangDanCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYMineZhangDanModel.h"

@interface DYMineZhangDanCell : UITableViewCell

@property (nonatomic, strong) NSArray *typeArray;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(DYMineZhangDanModel *)model;



@end
