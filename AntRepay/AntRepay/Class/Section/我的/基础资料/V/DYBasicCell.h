//
//  DYBasicCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYBasicCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithString:(NSString *)string;

/** 标题 **/
- (void)setValueWithTitle:(NSString *)title;

@end



/** icon cell **/
@interface DYBasicIconCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithString:(NSString *)string;

/** 标题 **/
- (void)setValueWithTitle:(NSString *)title;

@property (nonatomic, copy) void(^iconBlock)(void); // 更换头像

@end



/** third cell **/
@interface DYBasicThirdCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithString:(NSString *)string;

/** 标题 **/
- (void)setValueWithTitle:(NSString *)title;

@end
