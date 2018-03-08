//
//  DYBooksVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/9.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYBooksVC.h"
#import "DYTradeCell.h"
#import "DYTradeAlertView.h"
#import "DYTradeDetailVC.h"

@interface DYBooksVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) DYTradeAlertView *alertView;
@property (nonatomic, strong) UIButton *menuBtn; // 菜单按钮
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSMutableArray *typeArray;

@end

@implementation DYBooksVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"交易明细";
    self.isAddMJFooter = YES;
    self.type = @"";
}

-(void)dy_initUI{
    [super dy_initUI];
    self.tableView.xhq_height = kScreenHeight - kNavigationStatusHeight - kTabBarHeight;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    [self setMenuButton];
}

- (void)dy_reloadData {
   [self dy_refresh];
}

- (void)dy_request {
    [self typeReq];
}

- (void)dy_refresh {
    self.curtentPage = @"1";
    self.isRefresh = YES;
    
    [self requestDataSource];
}

- (void)dy_loadMore {
    self.curtentPage = [NSString stringWithFormat:@"%ld",[self.curtentPage integerValue] + 1];
    [self requestDataSource];
}

#pragma mark - 获取类型数据
- (void)typeReq {
    XHQHUDSHOW(self.view);
    [DYAppReq GET:_url_order_type param:nil callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self.typeArray removeAllObjects];
            if (DYAPPREQSUCCESS) {
                NSArray *type = responseObject[@"type"];
                for (NSDictionary *list in type) {
                    DYBooksTypeModel *model = [DYBooksTypeModel mj_objectWithKeyValues:list];
                    [self.typeArray addObject:model];
                }
            }
        }
        self.alertView.typeArray = self.typeArray;
    }];
}

#pragma mark - 列表数据
- (void)requestDataSource {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"type": self.type,
                            @"page": self.curtentPage
                            };
    [DYAppReq GET:_url_order_index param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            [self dy_isRefresh];
            if (DYAPPREQSUCCESS) {
                self.pageCount = responseObject[@"all_page"];
                NSArray *listArray = responseObject[@"list"];
                NSMutableArray *mArray = @[].mutableCopy;
                for (NSDictionary *list in listArray) {
                    [mArray addObject:[DYBooksMonthModel mj_objectWithKeyValues:list]];
                }
                [self setDataSourceWithListArray:mArray];
            }
        }else {
            XHQHUDFAIL(self.view);
        }
        [self dy_reqSuccessTableViewReloadData];
    }];
}

- (void)setDataSourceWithListArray:(NSMutableArray *)listArray {
    if (listArray.count == 0) return;
    
    if (self.dataArray.count == 0) {
        [self.dataArray addObjectsFromArray:listArray];
        return;
    }
    
    DYBooksMonthModel *monthModel = [self.dataArray lastObject];
    for (DYBooksMonthModel *model in listArray) {
        if ([monthModel.month isEqualToString:model.month]) {
            NSMutableArray *mArray = @[].mutableCopy;
            [mArray addObjectsFromArray: monthModel.order];
            [mArray addObjectsFromArray: model.order];
            monthModel.order = [mArray copy];
            
            [listArray removeObject:model];
            [self setDataSourceWithListArray:listArray];
            return;
        }
        else {
            [self.dataArray addObject:model];
        }
    }
}

- (void)setMenuButton{
    _menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_menuBtn setTitle:@"全部" forState:UIControlStateNormal];
    [_menuBtn setImage:kGetImage(@"xuanz_zhb") forState:UIControlStateNormal];
    [_menuBtn setImage:[UIImage imageNamed:@"xz_blue"] forState:UIControlStateSelected];
    [_menuBtn setTitleColor:KBlackColor forState:UIControlStateNormal];
    [_menuBtn setTitleColor:[UIColor xhq_base] forState:UIControlStateSelected];
    _menuBtn.titleLabel.font = kFont(14);
    _menuBtn.frame = CGRectMake(0, 0, BILIWIDTH(75), 44);
//    [_menuBtn sizeToFit];
    [_menuBtn xhq_addTarget:self action:@selector(menuAction:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_menuBtn];
    self.navigationItem.rightBarButtonItem = item;
    
    [self menuBtnEdgeInsets];
}

- (void)menuBtnEdgeInsets {
    CGFloat space = 5;
    _menuBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -_menuBtn.imageView.xhq_width, 0, _menuBtn.imageView.xhq_width);
    _menuBtn.imageEdgeInsets = UIEdgeInsetsMake(0, _menuBtn.titleLabel.xhq_width + space, 0, -_menuBtn.titleLabel.xhq_width - space);
}

/** 菜单按钮 **/
- (void)menuAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.alertView pop];
    }
    else {
        [self.alertView hide];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    DYBooksMonthModel *listModel = self.dataArray[section];
    return listModel.order.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTradeCell *cell = [DYTradeCell cellWithTableView:tableView];
    if (self.dataArray.count <= indexPath.section) {
        return cell;
    }
    DYBooksMonthModel *listModel = self.dataArray[indexPath.section];
    if (listModel.order.count <= indexPath.row) {
        return cell;
    }
    cell.typeArray = self.typeArray;
    cell.listModel = listModel.order[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DYTradeDetailVC *vc = [[DYTradeDetailVC alloc] init];
    DYBooksMonthModel *listModel = self.dataArray[indexPath.section];
    DYBooksListModel *model = listModel.order[indexPath.row];
    vc.detail_id = model.ID;
    vc.typeArray = self.typeArray;
    PUSHVC(vc);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(38))];
    view.backgroundColor = [UIColor xhq_section];
    UILabel *lable = [Utils labelWithTitleFontSize:14 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentLeft];
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(BILIWIDTH(12));
        make.centerY.equalTo(view.mas_centerY);
    }];
    DYBooksMonthModel *listModel = self.dataArray[section];
    lable.text = listModel.month;
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return BILIHEIGHT(38);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYTradeCell cellHeight];
}

#pragma mark - getter

- (DYTradeAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[DYTradeAlertView alloc]init];
        @weakify(self);
        _alertView.selectedBlock = ^(NSString *type, NSInteger tag) {
            @strongify(self);
            [self.menuBtn setTitle:type forState:UIControlStateNormal];
            [self menuBtnEdgeInsets];
            [self menuAction:self.menuBtn];
            self.type = tag == 0 ? @"" : [NSString stringWithFormat:@"%ld", tag];
            [self dy_refresh];
        };
        _alertView.cancelBlock = ^{
            @strongify(self);
            [self menuAction:self.menuBtn];
        };
    }
    return _alertView;
}

- (NSMutableArray *)typeArray {
    if (!_typeArray) {
        _typeArray = [[NSMutableArray alloc]init];
    }
    return _typeArray;
}

@end
