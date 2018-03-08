//
//  DYAboutVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAboutVC.h"
#import "DYAboutCell.h"

@interface DYAboutVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) UILabel *copyrightLabel;

@end

@implementation DYAboutVC

-(NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = [NSArray array];
        _titleArray = @[@"官方网站",@"官方微信",@"官方QQ"];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"关于";
    [self setupHeaderView];
    [self setupTableView];
    [self.view addSubview:self.copyrightLabel];
}

-(void)dy_request{
    XHQHUDSHOW(self.view);
    [DYAppReq GET:_url_about param:nil callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
//                [self.dataArray addObject:[NSString stringWithFormat:@"%@",responseObject[@"web_url"]]];
                [self.dataArray addObject:@"http://www.sdyipeng.com"];
                [self.dataArray addObject:[NSString stringWithFormat:@"%@",responseObject[@"wechat"]]];
                [self.dataArray addObject:[NSString stringWithFormat:@"%@",responseObject[@"QQ"]]];
                [self.tableView reloadData];
            }else{
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)setupHeaderView{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(182))];
    _imgView = [Utils imageViewWithImage:kGetImage(@"logo")];
    [_topView addSubview:_imgView];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(BILIWIDTH(157), BILIHEIGHT(83)));
        make.centerX.equalTo(_topView.mas_centerX);
        make.centerY.equalTo(_topView.mas_centerY);
    }];
}

- (void)setupTableView{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    self.tableView.tableHeaderView = _topView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYAboutCell *cell = [DYAboutCell cellWithTableView:tableView];
    [cell xhq_noneSelectionStyle];
    [cell setValueWithTitle:self.titleArray[indexPath.row]];
    if (self.dataArray.count > 0) {
        [cell setValueWithString:self.dataArray[indexPath.row]];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [DYAboutCell cellHeight];
}

#pragma mark - getter
- (UILabel *)copyrightLabel {
    if (!_copyrightLabel) {
        _copyrightLabel = [UILabel xhq_labelFrame:CGRectMake(BILIWIDTH(10), kScreenHeight - kNavigationStatusHeight - BILIHEIGHT(50), kScreenWidth - BILIWIDTH(20), BILIHEIGHT(20))
                                          bgColor:[UIColor clearColor]
                                        textColor:[UIColor xhq_content]
                                    textAlignment:1
                                             font:[UIFont xhq_font12]
                                             text:@"Copyright © 2018 山东一鹏信息科技有限公司 版权所有"];
    }
    return _copyrightLabel;
}


@end
