//
//  DYMessageDetailVC.m
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYMessageDetailVC.h"
#import "DYMessageDetailView.h"

@interface DYMessageDetailVC ()
@property (nonatomic, strong) DYMessageDetailView *detailView;
@end

@implementation DYMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

- (void)requestData{
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{@"id":self.mId};
    [DYAppReq GET:_url_message_detail param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *dic = responseObject[@"info"];
                [_detailView setTitle:dic[@"title"] time:dic[@"time"] content:dic[@"content"]];
                
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"消息详情";
    _detailView = [[DYMessageDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:_detailView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
