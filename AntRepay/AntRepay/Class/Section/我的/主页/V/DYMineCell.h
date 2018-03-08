//
//  DYMineCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMineCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

- (void)setValueWithModel:(NSDictionary *)model; 

@end



/** 上下文字view **/
@interface DYTitleView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end


/** 充值提现 **/
@interface DYMineRechargeCell : UITableViewCell
@property (nonatomic, strong) UIButton *rechargeBtn; // 充值
@property (nonatomic, strong) UIButton *tiXianBtn; // 提现

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@property (nonatomic, copy) void(^rechargeBlock)(void); // 充值
@property (nonatomic, copy) void(^tiXianBlock)(void);   // 提现

@end


/** 下方cell **/
@interface DYMineThirdCell : UITableViewCell

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

+(instancetype)cellWithTableView:(UITableView *)tableView;
// 高度
+(CGFloat)cellHeight;

- (void)setTitle:(NSString *)title image:(NSString *)image;
@end



/** 按钮cell **/
@interface DYMineBtnCell : UITableViewCell

@property (nonatomic, strong) UIButton *exitBtn; // 退出按钮
+(instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, copy) void(^exitBlock)(void); // 安全退出
// 高度
+(CGFloat)cellHeight;
@end
