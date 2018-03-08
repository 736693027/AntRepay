//
//  DYAddXiaoFeiPlanVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/17.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAddXiaoFeiPlanVC.h"
#import "DYAddXiaoFeiPlanView.h"
#import "BRPickerView.h"
#import "DYAddXFRepeatTypeAlertVew.h"
#import "DYWeekAlertView.h"
#import "DYMonthAlertView.h"
#import "BRPickerView.h"
#import "DYPlanYuLanVC.h"
#import "DYSurePlanAlertView.h"
#import "PGDatePicker.h"

@interface DYAddXiaoFeiPlanVC ()<PGDatePickerDelegate>
@property (nonatomic, strong) DYAddXiaoFeiPlanView *planView;
@property (nonatomic, strong) DYAddXFRepeatTypeAlertVew *typeAlertView;
@property (nonatomic, strong) DYWeekAlertView *weekAlertView;
@property (nonatomic, strong) DYMonthAlertView *monthAlertView;
@property (nonatomic, strong) DYSurePlanAlertView *surePlanView;

@property (nonatomic, strong) NSMutableDictionary *param;
@property (nonatomic, strong) DYAddPayPlanModel *payModel;
@property (nonatomic, assign, getter=isStart) BOOL start;

@end

@implementation DYAddXiaoFeiPlanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"新增消费计划";
    
    _planView = [[DYAddXiaoFeiPlanView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _planView.payModel = self.payModel;
    [self.view addSubview:_planView];
    __weak typeof(_planView) weakPlanView = _planView;
    __weak typeof(self) weakSelf = self;
    // 开始日期
    _planView.startTimeBlock = ^(NSString *time) {
        weakSelf.start = YES;
        [weakSelf selectedStarAndEndDate];
        return ;
        [BRDatePickerView showDatePickerWithTitle:@"开始日期" dateType:UIDatePickerModeDate defaultSelValue:nil minDateStr:[NSDate currentDateString] maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
            weakPlanView.startTimeView.textField.text = selectValue;
        }];
    };
    // 结束日期
    _planView.endTimeBlock = ^(NSString *time) {
        weakSelf.start = NO;
        [weakSelf selectedStarAndEndDate];
        return ;
        [BRDatePickerView showDatePickerWithTitle:@"结束日期" dateType:UIDatePickerModeDate defaultSelValue:nil minDateStr:[NSDate currentDateString] maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
            weakPlanView.endTimeView.textField.text = selectValue;
        }];
    };
    // 重复类型
    _planView.repeatTypeBlock = ^(NSString *repeatType) {
        [weakSelf typeAlertViewShow];
    };
    // 重复内容
    _planView.repeatContentBlock = ^(NSString *repeatContent) {
        if ([weakPlanView.repeatTypeView.textField.text isEqualToString:@"每天"]) {
            [weakSelf dayAlertView];
        }else if ([weakPlanView.repeatTypeView.textField.text isEqualToString:@"每周"]) {
            [weakSelf weekAlertViewShow];
        }else if ([weakPlanView.repeatTypeView.textField.text isEqualToString:@"每月"]){
            [weakSelf monthAlertViewShow];
        }else {
            XHQHUDTEXT(@"请先选择重复类型");
        }
    };
    
    @weakify(self);
    // 计划预览
    _planView.planYuLanBlock = ^{
        @strongify(self);
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"请确认消费计划是否正确,计划提交后不可更改",
                                    @"确认提交",
                                    @"不提交",
                                    [self payDateWithTypeReq]);
    };
}

// 重复类型
- (void)typeAlertViewShow{
    _typeAlertView = [[DYAddXFRepeatTypeAlertVew alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _typeAlertView.bottomView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, BILIHEIGHT(195));
    [[UIApplication sharedApplication].keyWindow addSubview:_typeAlertView];
    [UIView animateWithDuration:0.2 animations:^{
        _typeAlertView.bottomView.frame = CGRectMake(0, kScreenHeight-BILIHEIGHT(195), kScreenWidth, BILIHEIGHT(195));
    }];
    _planView.repeatContentView.textField.text = @"";
    __weak typeof(_planView) weakPlanView = _planView;
    _typeAlertView.dayBlock = ^(NSString *day) {
        weakPlanView.repeatTypeView.textField.text = day;
    };
    _typeAlertView.weekBlock = ^(NSString *week) {
        weakPlanView.repeatTypeView.textField.text = week;
    };
    _typeAlertView.monthBlock = ^(NSString *month) {
        weakPlanView.repeatTypeView.textField.text = month;
    };
}

// 按天
- (void)dayAlertView{
    __block NSArray *dataSource = @[@"每1天",@"每2天",@"每3天",@"每4天",@"每5天",@"每6天",@"每7天"];
    __block NSArray *keys = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7",];
    [BRStringPickerView showStringPickerWithTitle:@"" dataSource:dataSource defaultSelValue:@"每3天" isAutoSelect:NO resultBlock:^(id selectValue) {
        _planView.repeatContentView.textField.text = selectValue;
        self.payModel.repeatKey = keys[[dataSource indexOfObject:selectValue]];
    }];
}

// 按周 alertview
- (void)weekAlertViewShow{
    _weekAlertView = [[DYWeekAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:_weekAlertView];
    _weekAlertView.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.2 animations:^{
        _weekAlertView.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    __weak typeof(_planView) weakPlanView = _planView;
    @weakify(self);
    // 确定
    _weekAlertView.sureBlock = ^(NSString *weekStr,NSString *weekChuanStr) {
        @strongify(self);
        weakPlanView.repeatContentView.textField.text = weekStr;
        self.payModel.repeatKey = weekChuanStr;
    };
}

// 按月 alertview
- (void)monthAlertViewShow{
    _monthAlertView = [[DYMonthAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:_monthAlertView];
    _monthAlertView.alertView.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [UIView animateWithDuration:0.2 animations:^{
        _monthAlertView.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    __weak typeof(_planView) weakPlanView = _planView;
    @weakify(self);
    // 确定
    _monthAlertView.sureBlock = ^(NSString *monthStr,NSString *monthChuanStr) {
        @strongify(self);
        weakPlanView.repeatContentView.textField.text = monthStr;
        self.payModel.repeatKey = monthChuanStr;
    };
}

// 提交 alertview
- (void)sureAlertViewShow{
    _surePlanView = [[DYSurePlanAlertView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [[UIApplication sharedApplication].keyWindow addSubview:_surePlanView];
    // 确认
    _surePlanView.sureBlock = ^{
        
    };
}

#pragma mark - 数据请求
#pragma mark - 按天
- (void)payDateWithTypeReq {
    XHQHUDSHOW(self.view);
    NSMutableDictionary *param = [@{
                            @"start": self.payModel.startDateString,
                            @"end": self.payModel.endDateString
                            } mutableCopy];
    NSString *urlString;
    switch (self.payModel.repeatType) {
        case payPlanRepeatTypeMonth:
            urlString = _url_date_month;
            [param setValue:self.payModel.repeatKey forKey:@"month"];
            break;
        case payPlanRepeatTypeWeek:
            urlString = _url_date_week;
            [param setValue:self.payModel.repeatKey forKey:@"week"];
            break;
        case payPlanRepeatTypeDays:
            urlString = _url_date_days;
            [param setValue:self.payModel.repeatKey forKey:@"num"];
            break;
        default:
            break;
    }
    [DYAppReq GET:urlString param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSString *message = responseObject[@"message"];
                [self.param setValue:message forKey:@"date"];
                [self previewSubmitReq];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 数据提交预览
- (void)previewSubmitReq {
    XHQHUDSHOW(self.view);
    [self.param setValue:self.payModel.money forKey:@"money"];
    [DYAppReq POST:_url_pay_preview param:self.param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSArray *listArray = responseObject[@"list"];
                [self submitSuccess:listArray];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)submitSuccess:(NSArray *)listArray {
    DYPlanYuLanVC *vc = [[DYPlanYuLanVC alloc]init];
    vc.listArray = listArray;
    vc.card_id = self.card_id;
    vc.money = self.payModel.money;
    vc.date = self.param[@"date"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 选择起止日期
- (void)selectedStarAndEndDate {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.confirmButtonTextColor = [UIColor xhq_base];
    datePicker.textColorOfSelectedRow = [UIColor xhq_aTitle];
    datePicker.lineBackgroundColor = [UIColor xhq_content];
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.minimumDate = [NSDate date];
    if (self.isStart) {
        datePicker.titleLabel.text = @"选择开始日期";
    }
    else {
        datePicker.titleLabel.text = @"选择结束日期";
    }
}

#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *year = [NSString stringWithFormat:@"%ld", dateComponents.year];
    NSString *month = [NSString stringWithFormat:@"%ld", dateComponents.month];
    NSString *day = [NSString stringWithFormat:@"%ld", dateComponents.day];
    if (self.isStart) {
        _planView.startTimeView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
    else {
        _planView.endTimeView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
}

#pragma mark - getter
- (NSMutableDictionary *)param {
    if (!_param) {
        _param = [
                  @{
                    DY_APP_KEY_VALUE_REQ,
                    @"cardid": self.card_id
                    }
                  mutableCopy];
    }
    return _param;
}

- (DYAddPayPlanModel *)payModel {
    if (!_payModel) {
        _payModel = [[DYAddPayPlanModel alloc]init];
    }
    return _payModel;
}

@end
