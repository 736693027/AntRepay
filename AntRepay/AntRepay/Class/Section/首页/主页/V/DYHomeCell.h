//
//  DYHomeCell.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYHomeCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *noticeArray;

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@end

typedef NS_ENUM(NSInteger, HomeType) {
    HomeTypeAccount = 1,
    HomeTypeExtension,
    HomeTypeAbout,
    HomeTypeAgent,
};

typedef void(^DYHomeSecondCellBlock)(HomeType type);
@interface DYHomeSecondCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

+(CGFloat)cellHeight;

@property (nonatomic, copy) DYHomeSecondCellBlock block;

@end
