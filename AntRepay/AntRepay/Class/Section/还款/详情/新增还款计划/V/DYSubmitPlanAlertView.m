//
//  DYSubmitPlanAlertView.m
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/3.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYSubmitPlanAlertView.h"
#import "DYAddRepaymentPlanModel.h"

@interface DYSubmitPlanAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

static const NSTimeInterval kAnimationDuration = 0.4;

@implementation DYSubmitPlanAlertView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.container];
    [self.container addSubview:self.tableView];
    [self.container addSubview:self.sureButton];
    [self.container addSubview:self.cancelButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_container makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(0);
        make.size.equalTo(CGSizeMake(BILIWIDTH(300), BILIHEIGHT(230)));
    }];
    [_tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.insets(UIEdgeInsetsMake(BILIHEIGHT(10), BILIHEIGHT(10), 0, BILIHEIGHT(10)));
        make.bottom.equalTo(_sureButton.top).offset(BILIHEIGHT(-10));
    }];
    [_sureButton makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(BILIHEIGHT(-10));
        make.right.equalTo(BILIWIDTH(-10));
        make.size.equalTo(CGSizeMake(BILIWIDTH(70), BILIHEIGHT(25)));
    }];
    [_cancelButton makeConstraints:^(MASConstraintMaker *make) {
        make.size.bottom.equalTo(_sureButton);
        make.right.equalTo(_sureButton.left).offset(BILIWIDTH(-10));
    }];
}

#pragma mark - 取消
- (void)cancelButtonClicked {
    [self dismiss];
}

#pragma mark - 确定
- (void)sureButtonClicked {
    if (self.block) {
        self.block();
    }
    [self dismiss];
}

#pragma mark - private
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self]) {
        [self dismiss];
    }
}

- (void)dismiss {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.container.transform = CGAffineTransformMakeScale(0.001, 0.001);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - public
- (void)pop {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    
    self.container.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.container.transform = CGAffineTransformIdentity;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }];
}

#pragma mark - tableViewD
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DYTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.hideSeparatorLabel = YES;
        [cell xhq_noneSelectionStyle];
        cell.textLabel.textColor = [UIColor xhq_content];
        cell.textLabel.font = [UIFont xhq_font14];
        cell.detailTextLabel.font = [UIFont xhq_font16];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = self.dataArray[indexPath.row];
    if (indexPath.row != 3) {
        cell.detailTextLabel.textColor = [UIColor xhq_aTitle];
    }else {
        cell.detailTextLabel.textColor = [UIColor xhq_red];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return BILIHEIGHT(40);
}

#pragma mark - setter
- (void)setSubmitModel:(DYAddRepaymentSubmitModel *)submitModel {
    _submitModel = submitModel;
    if ([NSObject xhq_notNULL:submitModel.pay_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"￥%@", submitModel.pay_money]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    if ([NSObject xhq_notNULL:submitModel.repayment_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"￥%@", submitModel.repayment_money]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    if ([NSObject xhq_notNULL:submitModel.fee_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"￥%@", submitModel.fee_money]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    if ([NSObject xhq_notNULL:submitModel.min_money]) {
        [self.dataArray addObject:[NSString stringWithFormat:@"￥%@", submitModel.min_money]];
    }else {
        [self.dataArray addObject:@"--"];
    }
    
    [self.tableView reloadData];
}

#pragma mark - getter
- (UIView *)container {
    if (!_container) {
        _container = [[UIView alloc]init];
        _container.backgroundColor = [UIColor whiteColor];
        _container.layer.cornerRadius = 3;
        _container.layer.masksToBounds = YES;
    }
    return _container;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =  self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
        [_tableView xhq_registerCell:[DYTableViewCell class]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton xhq_buttonFrame:CGRectZero
                                        bgColor:[UIColor clearColor]
                                     titleColor:[UIColor xhq_base]
                                    borderWidth:0
                                    borderColor:nil
                                   cornerRadius:0
                                            tag:0
                                         target:self
                                         action:@selector(sureButtonClicked)
                                          title:@"确定"];
        _sureButton.xhqFont = [UIFont xhq_font14];
    }
    return _sureButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton xhq_buttonFrame:CGRectZero
                                          bgColor:[UIColor clearColor]
                                       titleColor:[UIColor grayColor]
                                      borderWidth:0
                                      borderColor:nil
                                     cornerRadius:0
                                              tag:0
                                           target:self
                                           action:@selector(cancelButtonClicked)
                                            title:@"取消"];
        _cancelButton.xhqFont = [UIFont xhq_font14];
    }
    return _cancelButton;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
                        @"消费总额",
                        @"还款总额",
                        @"手续费总额",
                        @"信用卡建议预留额度"
                        ];
    }
    return _titleArray;
}

@end
