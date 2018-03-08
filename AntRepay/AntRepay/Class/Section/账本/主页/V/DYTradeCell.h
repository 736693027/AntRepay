//
//  DYTradeDetailCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYBooksModel.h"

@interface DYTradeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSArray *)model;

@property (nonatomic, strong) DYBooksListModel *listModel;
@property (nonatomic, strong) NSArray *typeArray;

@end
