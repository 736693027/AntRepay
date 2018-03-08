//
//  DYAboutCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYAboutCell : UITableViewCell

// 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView;
// 高度
+(CGFloat)cellHeight;

// 标题
- (void)setValueWithTitle:(NSString *)title;

- (void)setValueWithString:(NSString *)string;

@end
