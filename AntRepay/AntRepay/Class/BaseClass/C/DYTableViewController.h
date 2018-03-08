//
//  DYTableViewController.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"

typedef NS_ENUM(NSInteger, DYTableViewStyle) {
    DYTableViewStylePlain = 0,
    DYTableViewStyleGrouped
};

@interface DYTableViewController : DYViewController<
UITableViewDataSource,
UITableViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) DYTableViewStyle style;

@end
