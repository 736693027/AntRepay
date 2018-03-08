//
//  DYSettingCell.h
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYTableViewCell.h"

@interface DYSettingCell : DYTableViewCell

// 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView;
// 高度
+(CGFloat)cellHeight;

- (void)setValueWithString:(NSString *)string;

@end



@interface DYSettingSecondCell : DYTableViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *imgView;

// 初始化
+(instancetype)cellWithTableView:(UITableView *)tableView;
// 高度
+(CGFloat)cellHeight;
// 赋值
-(void)setValueWithPhone:(NSString *)phone time:(NSString *)time;

@end
