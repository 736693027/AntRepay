//
//  DYSafeDetailVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSafeDetailVC.h"
#import "DYSafeCell.h"

@interface DYSafeDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSArray *titleArr;;
@end

@implementation DYSafeDetailVC

-(NSArray *)titleArr{
    if (!_titleArr) {
        _titleArr = [NSArray array];
        _titleArr = @[@"保障对象",@"投保单号",@"保单号",@"被保险人",@"保障开始时间",@"保障结束时间",@"保障金额",@"保险费"];
    }
    return _titleArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"保险详情";
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(311))];
    _imgView.image = kGetImage(@"top_bx");
    self.tableView.backgroundColor = [UIColor xhq_section];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = _imgView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 8) {
        DYSafeDetailBottomCell *cell = [DYSafeDetailBottomCell cellWithTableView:tableView];
        [cell setValueWithPhone:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 保险条款
        cell.tiaoKuanBlock = ^{
            
        };
        return cell;
    }
    DYSafeDetailCell *cell = [DYSafeDetailCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithTitle:self.titleArr[indexPath.row]];
    [cell setValueWithContent:@"内容"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 8) {
        return [DYSafeDetailBottomCell cellHeight];
    }
    return [DYSafeDetailCell cellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
