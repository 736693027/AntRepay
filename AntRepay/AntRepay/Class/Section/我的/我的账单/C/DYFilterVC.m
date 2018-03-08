//
//  DYFilterVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYFilterVC.h"
#import "DYFilterView.h"
#import "WSDatePickerView.h"
#import "BRPickerView.h"
#import "PGDatePicker.h"
#import "DYMineZhangDanModel.h"

@interface DYFilterVC ()<PGDatePickerDelegate>
@property (nonatomic, strong) DYFilterView *filterView;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) BOOL isStart;
@end

@implementation DYFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"筛选";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(doneAction:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor xhq_base]}
                                                          forState:UIControlStateNormal];
    [self aboutFilterView];
    _type = @"";
}

- (void)aboutFilterView{
    _filterView = [[DYFilterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTopHeight)];
    [self.view addSubview:_filterView];
    @weakify(self);
    // 选择类型
    _filterView.typeBlock = ^(NSString *type) {
        @strongify(self);
        [self typeAlertView];
    };
    // 开始时间
    _filterView.startTimeBlock = ^(NSString *time,NSString *num) {
        @strongify(self);
        self.isStart = YES;
        [self selectedStarAndEndDate];
    };
    // 结束时间
    _filterView.endTimeBlock = ^(NSString *time,NSString *num) {
        @strongify(self);
        self.isStart = NO;
        [self selectedStarAndEndDate];
    };
}

// 选择类型
- (void)typeAlertView{
    
    NSMutableArray *mNameArray = @[].mutableCopy, *mNumArray = @[].mutableCopy;
    [mNameArray addObject:@"全部"];
    [mNumArray addObject:@"0"];
    for (DYMineZhangDanTypeModel *model in self.typeArray) {
        [mNameArray addObject:model.name];
        [mNumArray addObject:model.value];
    }
    
    [BRStringPickerView showStringPickerWithTitle:@""
                                       dataSource:mNameArray
                                  defaultSelValue:nil
                                     isAutoSelect:NO
                                      resultBlock:^(id selectValue) {
                                          _filterView.typeView.textField.text = selectValue;
                                          _type = mNumArray[[mNameArray indexOfObject:selectValue]];
                                      }];
}

// 时间选择器
- (void)aboutTimeWithNum:(NSString *)num{
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDay CompleteBlock:^(NSDate *selectDate) {
        
        NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
        if ([num isEqualToString:@"1"]) {
            _startDate = date;
            _filterView.startView.textField.text = date;
        }else if ([num isEqualToString:@"2"]){
            _endDate = date;
            _filterView.endView.textField.text = date;
        }
       
        
    }];
    datepicker.maxLimitDate = [NSDate date];  // 设置最大时间
    datepicker.dateLabelColor = [UIColor xhq_base];//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = [UIColor xhq_base];//确定按钮的颜色
    [datepicker show];
}

- (void)selectedStarAndEndDate {
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
        _startDate = _filterView.startView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
    else {
        _endDate = _filterView.endView.textField.text = [NSString stringWithFormat:@"%@-%@-%@", year,month,day];
    }
}

// 完成
- (void)doneAction:(UIButton *)sender{
    if (![NSString xhq_notEmpty:_filterView.typeView.textField.text] &&
        ![NSString xhq_notEmpty:self.startDate] &&
        ![NSString xhq_notEmpty:self.endDate]) {
        XHQHUDTEXT(@"请选择筛选条件");
        return;
    }
    if ([NSString xhq_notEmpty:self.startDate] &&
        [NSString xhq_notEmpty:self.endDate] &&
        [self compareDate:_startDate withDate:_endDate] == -1) {
        XHQHUDTEXT(@"时间格式错误");
        return;
    }
    if (self.filterBlock) {
        self.filterBlock(self.type, self.startDate, self.endDate);
    }
    [self.navigationController popViewControllerAnimated:YES];
    /*
    if (!_filterView.typeView.textField.text.length) {
        XHQHUDTEXT(@"请选择类型");
    }else if (!_filterView.startView.textField.text.length){
        XHQHUDTEXT(@"请选择开始时间");
    }else if (!_filterView.endView.textField.text.length){
        XHQHUDTEXT(@"请选择结束时间");
    }else {
        int result = [self compareDate:_startDate withDate:_endDate];
        if (result == -1){
            XHQHUDTEXT(@"时间格式错误");
        }else{
            // 传值回去
            self.filterBlock(self.type, self.startDate, self.endDate);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
     */
}

//比较两个日期大小
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
