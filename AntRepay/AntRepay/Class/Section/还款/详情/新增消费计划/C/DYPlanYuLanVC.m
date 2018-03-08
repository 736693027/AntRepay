//
//  DYPlanYuLanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/18.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYPlanYuLanVC.h"
#import "DYPlanYuLanCell.h"
#import "UIViewController+Ext.h"


@interface DYPlanYuLanVC ()


@end

@implementation DYPlanYuLanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"预览计划";
    
    for (NSDictionary *list in self.listArray) {
        [self.dataArray addObject:[DYAddPayPlanpPreviewModel mj_objectWithKeyValues:list]];
    }
}

-(void)dy_initUI{
    [super dy_initUI];
    
    self.tableView.tableFooterView = [self tableFooterView];
}

#pragma mark - 提交
- (void)submitButtonOperation {
    XHQHUDSHOW(self.view);
    NSDictionary *param = @{
                            DY_APP_KEY_VALUE_REQ,
                            @"cardid": self.card_id,
                            @"date": self.date,
                            @"money": self.money
                            };
    [DYAppReq POST:_url_pay_add param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:3]);
                [self xhq_postObserveNotification:DYCardPayPlanCleanNotification];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
    
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYPlanYuLanCell *cell = [DYPlanYuLanCell cellWithTableView:tableView];
    if (self.dataArray.count <= indexPath.row) {
        return cell;
    }
    cell.payModel = self.dataArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYPlanYuLanCell cellHeight];
}

#pragma mark - getter

- (UIView *)tableFooterView {
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(100))];
    UIButton *submit = [UIButton xhq_buttonFrame:CGRectZero
                                         bgColor:[UIColor xhq_base]
                                      titleColor:[UIColor whiteColor]
                                     borderWidth:0
                                     borderColor:nil
                                    cornerRadius:5
                                             tag:0
                                          target:self
                                          action:@selector(submitButtonOperation)
                                           title:@"提交计划"];
    submit.xhqFont = [UIFont xhq_font16];
    [footView addSubview:submit];
    [submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.size.equalTo(CGSizeMake(BILIWIDTH(352), BILIHEIGHT(38)));
    }];
    return footView;
}

@end
