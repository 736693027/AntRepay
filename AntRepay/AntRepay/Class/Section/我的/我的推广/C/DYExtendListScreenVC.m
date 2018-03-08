//
//  DYExtendListScreenVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYExtendListScreenVC.h"
#import "DYExtendListScreenView.h"
#import "PGDatePicker.h"

@interface DYExtendListScreenVC ()<PGDatePickerDelegate>

@property (nonatomic, strong) DYExtendListScreenView *screenView;

@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, assign) BOOL isStart;

@end

@implementation DYExtendListScreenVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = @"筛选";
}

- (void)dy_initUI {
    [super dy_initUI];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneAction)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor xhq_base]}
                                                          forState:UIControlStateNormal];
    
    [self.view addSubview:self.screenView];
}

#pragma mark - 完成
- (void)doneAction {
    if (![NSString xhq_notEmpty:_screenView.typeView.textField.text] &&
        ![NSString xhq_notEmpty:self.startDate] &&
        ![NSString xhq_notEmpty:self.endDate]) {
        XHQHUDTEXT(@"选输入筛选条件");
        return;
    }
    if ([NSString xhq_notEmpty:_screenView.typeView.textField.text] &&
        ![NSString xhq_phoneFormatCheck:_screenView.typeView.textField.text tip:@"手机号"]) {
        return;
    }
    if ([NSString xhq_notEmpty:self.startDate] &&
        [NSString xhq_notEmpty:self.endDate] &&
        [self compareDate:self.startDate withDate:self.endDate] == -1) {
        XHQHUDTEXT(@"时间格式错误");
        return;
    }
    
    if (self.block) {
        self.block(_screenView.typeView.textField.text, self.startDate, self.endDate);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 比较两个日期大小
-(int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

#pragma mark - 选择日期
- (void)selectedTime {
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.datePickerMode = PGDatePickerModeDate;
    datePicker.confirmButtonTextColor = [UIColor xhq_base];
    datePicker.textColorOfSelectedRow = [UIColor xhq_aTitle];
    datePicker.lineBackgroundColor = [UIColor xhq_content];
    datePicker.maximumDate = [NSDate date];
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
        _startDate = _screenView.startView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
    else {
        _endDate = _screenView.endView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
}

#pragma mark - getter
- (DYExtendListScreenView *)screenView {
    if (!_screenView) {
        _screenView = [[DYExtendListScreenView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationStatusHeight)];
        @weakify(self);
        _screenView.block = ^(BOOL isStart) {
            @strongify(self);
            self.isStart = isStart;
            [self selectedTime];
        };
    }
    return _screenView;
}



@end
