//
//  DYSafeVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/14.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSafeVC.h"
#import "DYSafeCell.h"
#import "DYSafeDetailVC.h"

@interface DYSafeVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation DYSafeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    self.title = @"保险";
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.tableView.backgroundColor = [UIColor xhq_section];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYSafeCell *cell = [DYSafeCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithModel:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYSafeDetailVC *vc = [[DYSafeDetailVC alloc] init];
    PUSHVC(vc);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYSafeCell cellHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
