//
//  DYZhangDanDetailVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYZhangDanDetailVC.h"
#import "DYZhangDanDetailView.h"

@interface DYZhangDanDetailVC ()
@property (nonatomic, strong) DYZhangDanDetailView *detailView;
@end

@implementation DYZhangDanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.view.backgroundColor = [UIColor xhq_section];
    self.title = @"账单详情";
    _detailView = [[DYZhangDanDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(350))];
    _detailView.typeArray = self.typeArray;
    [self.view addSubview:_detailView];
}

-(void)dy_request{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"id":self.idStr};
    [DYAppReq GET:_url_zhangDan_detail param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [_detailView setValueWithDictionary:responseObject[@"info"]];
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
