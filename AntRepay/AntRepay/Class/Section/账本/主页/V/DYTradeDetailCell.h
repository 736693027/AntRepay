//
//  DYTradeDetailCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYBooksModel.h"

@interface DYTradeDetailCell : UITableViewCell

@property (nonatomic, strong) DYBooksDetailModel *detailModel;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSArray *)model;

@end



/** 带图片cell **/
@interface DYTradeDetailSecondCell : UITableViewCell

@property (nonatomic, strong) DYBooksDetailModel *detailModel;
@property (nonatomic, strong) NSArray *typeArray;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSArray *)model;

@end



/** 第3种cell **/
@interface DYTradeDetailThirdCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSString *)model;

// 标题
- (void)setValueWithTitle:(NSString *)title;

@end
