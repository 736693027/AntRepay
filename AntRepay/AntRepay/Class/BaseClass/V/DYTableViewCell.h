//
//  DYTableViewCell.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/19.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *separatorLabel;
@property (nonatomic, assign) BOOL hideSeparatorLabel;

- (void)dy_initUI;

@end
