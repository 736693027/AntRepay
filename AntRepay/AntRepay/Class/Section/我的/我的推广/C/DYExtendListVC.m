//
//  DYExtendListVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYExtendListVC.h"
#import "DYExtendListScreenVC.h"

#import "DYExtendListView.h"

@interface DYExtendListVC ()

@property (nonatomic, strong) NSString *phoneString;
@property (nonatomic, strong) NSString *startTimeString;
@property (nonatomic, strong) NSString *endTimeString;

@end

static NSString *const _image_screen = @"sxuan";

@implementation DYExtendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"推广记录";
    self.isAddMJFooter = YES;
}

- (void)dy_initUI {
    [super dy_initUI];
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    
    [self.tableView xhq_registerCell:[DYExtendListCell class]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:_image_screen]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(screen)];
}

- (void)dy_request {
    [self dy_HUDBGShow];
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"page": self.curtentPage,
                            @"start_time": self.startTimeString,
                            @"end_time": self.endTimeString,
                            @"phone": self.phoneString
                            };
    [DYAppReq GET:_url_extend_more param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = [NSString stringWithFormat:@"%@", responseObject[@"all_page"]];
                NSArray *listArray = responseObject[@"list"];
                for (DYExtendListModel *list in listArray) {
                    [self.dataArray addObject:[DYExtendListModel mj_objectWithKeyValues:list]];
                }
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

#pragma mark - 筛选
- (void)screen {
    DYExtendListScreenVC *screen = [[DYExtendListScreenVC alloc]init];
    screen.block = ^(NSString *phone, NSString *start, NSString *end) {
        self.phoneString = phone;
        self.startTimeString = start;
        self.endTimeString = end;
        [self dy_refresh];
    };
    [self.navigationController pushViewController:screen animated:YES];
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYExtendListCell *cell = [tableView xhq_dequeueCell:[DYExtendListCell class] indexPath:indexPath];
    cell.listModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[DYExtendListSectonView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.dataArray.count == 0 ? 0 : 44;
}


@end
