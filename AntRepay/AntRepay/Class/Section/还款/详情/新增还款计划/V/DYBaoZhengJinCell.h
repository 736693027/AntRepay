//
//  DYBaoZhengJinCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYBaoZhengJinCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

// 设置title
- (void)setValueWithTitle:(NSString *)title;

- (void)setValueWithString:(NSString *)model;

@end


typedef void(^DYBaoZhengYuECellBlock)(void);
@interface DYBaoZhengYuECell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithString:(NSString *)model;

@property (nonatomic, copy) DYBaoZhengYuECellBlock block;

@end
