//
//  DYMJRefreshViewController.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYMJRefreshViewController.h"
#import "MJRefresh.h"

@interface DYMJRefreshViewController ()

@end

static NSString *const currentPageString = @"1";

@implementation DYMJRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.curtentPage = currentPageString;
    self.isAddMJFooter = NO;
}

- (void)dy_initUI {
    [super dy_initUI];
    
    @weakify(self);
    [self.tableView xhq_refreshHeaderBlock:^{
        @strongify(self);
        [self dy_refresh];
    }];
    if (self.isAddMJFooter) {
        [self.tableView xhq_refreshFooterBlock:^{
            @strongify(self);
            [self dy_loadMore];
        }];
    }
}

- (void)dy_refresh {
    self.curtentPage = currentPageString;
    self.isRefresh = YES;
    [self dy_request];
}

- (void)dy_loadMore {
    self.curtentPage = [NSString stringWithFormat:@"%ld",[self.curtentPage integerValue] + 1];
    [self dy_request];
}

- (void)dy_noMoreDataFooter {
    if ([self.curtentPage integerValue] >= [self.pageCount integerValue]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)dy_hiddenMJFooter:(NSArray *)array {
    if (!array) {
        array = self.dataArray;
    }
    if (array.count > 0) {
        self.tableView.mj_footer.hidden = NO;
    }else {
        self.tableView.mj_footer.hidden = YES;
    }
}

- (void)dy_stopRefresh {
    [self.tableView xhq_stopRefresh];
}

- (void)dy_isRefresh {
    if (self.isRefresh) {
        self.isRefresh = !self.isRefresh;
        [self.dataArray removeAllObjects];
    }
}

- (void)dy_reqSuccessTableViewReloadData {
    [self dy_stopRefresh];
    [self.tableView reloadData];
    [self dy_noMoreDataFooter];
    [self dy_hiddenMJFooter:nil];
}

@end





@implementation UIScrollView (XHQRefresh)

- (void)xhq_refreshHeaderBlock:(void (^)(void))block {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    header.lastUpdatedTimeLabel.hidden = YES;
    //自定义...
        header.stateLabel.font = XHQ_FONT(13);
    self.mj_header = header;
}

- (void)xhq_refreshFooterBlock:(void (^)(void))block {
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:block];
    //自定义...
    footer.stateLabel.font = XHQ_FONT(13);
    self.mj_footer = footer;

}

- (void)xhq_stopRefresh {
    if ([self.mj_header isRefreshing]) {
        [self.mj_header endRefreshing];
    }
    if ([self.mj_footer isRefreshing]) {
        [self.mj_footer endRefreshing];
    }
}

@end
