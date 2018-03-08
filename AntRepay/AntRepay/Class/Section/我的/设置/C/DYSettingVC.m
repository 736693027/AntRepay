//
//  DYSettingVC.m
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYSettingVC.h"
#import "DYSettingCell.h"
#import "DYUserInstructionsVC.h"
#import "DYAboutVC.h"

@interface DYSettingVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSDictionary *kefuDic; // 客服
@end

@implementation DYSettingVC

-(NSDictionary *)kefuDic{
    if (!_kefuDic) {
        _kefuDic = [NSDictionary dictionary];
    }
    return _kefuDic;
}

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"用户须知",@"关于"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
}

-(void)dy_request{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_kefu param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                self.kefuDic = responseObject;
                [self.tableView reloadData];
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        DYSettingSecondCell *cell = [DYSettingSecondCell cellWithTableView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setValueWithPhone:self.kefuDic[@"phone"] time:self.kefuDic[@"time"]];
        return cell;
    }
    DYSettingCell *cell = [DYSettingCell cellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setValueWithString:self.titleArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        DYUserInstructionsVC *vc = [[DYUserInstructionsVC alloc] init];
        PUSHVC(vc);
    }else if (indexPath.row == 1){
        DYAboutVC *vc = [[DYAboutVC alloc] init];
        PUSHVC(vc);
    }else if (indexPath.row == 2){
        // 打电话
        UIWebView *callView = [[UIWebView alloc] init];
        NSURL *telURL = [NSURL URLWithString:NSStringFormat(@"tel://%@",self.kefuDic[@"phone"])];
        [callView loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callView];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        return [DYSettingSecondCell cellHeight];
    }
    return [DYSettingCell cellHeight];
}

@end
