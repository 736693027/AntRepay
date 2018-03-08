//
//  DYSafeCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYSafeCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSArray *)model;

@end




/** 详情cell **/
@interface DYSafeDetailCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithTitle:(NSString *)title; // 标题
- (void)setValueWithContent:(NSString *)content; // 右侧内容

@end



/** 详情底部cell **/
@interface DYSafeDetailBottomCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithPhone:(NSString *)phone;

@property (nonatomic, copy) void(^tiaoKuanBlock)(void);

@end

