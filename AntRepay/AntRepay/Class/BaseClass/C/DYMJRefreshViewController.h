//
//  DYMJRefreshViewController.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/16.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYTableViewController.h"

@interface DYMJRefreshViewController : DYTableViewController

@property (nonatomic, strong) NSString *curtentPage; /**<当前分页*/
@property (nonatomic, strong) NSString *pageCount; /**<总页数*/
@property (nonatomic, assign) BOOL isRefresh; /**<是否下拉刷新*/
@property (nonatomic, assign) BOOL isAddMJFooter; /**<是否添加上拉加载 默认不添加*/

- (void)dy_refresh;  /**<下拉刷新*/
- (void)dy_loadMore;  /**<上拉加载*/

- (void)dy_noMoreDataFooter; /**<上拉已无更多数据*/

- (void)dy_hiddenMJFooter:(NSArray *)array; /**<是否隐藏上拉加载*/

- (void)dy_stopRefresh; /**<停止刷新*/

- (void)dy_reqSuccessTableViewReloadData;  /**<列表数据请求成功刷新tableView*/

- (void)dy_isRefresh;  /**<上拉刷新操作*/

@end

#pragma mark - UIScrollView+XHQRefresh

/**
 自定义刷新
 */
@interface UIScrollView (XHQRefresh)

- (void)xhq_refreshHeaderBlock:(void(^)(void))block;

- (void)xhq_refreshFooterBlock:(void(^)(void))block;

- (void)xhq_stopRefresh;

@end
