//
//  DYSelectedRepayDateView.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYSelectedRepayDateView.h"
#import "FSCalendar.h"

@interface DYSelectedRepayDateView ()<
FSCalendarDelegate,
FSCalendarDataSource>

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) FSCalendar *calendar;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *confrimButton;
@property (nonatomic, strong) UIButton *cancelButton;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *maximumDate;
@property (nonatomic, strong) NSMutableArray *dateArray;

@end

static const NSTimeInterval kDuration = 0.3;

@implementation DYSelectedRepayDateView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.calendar];
    [self.containerView addSubview:self.nextButton];
    [self.containerView addSubview:self.previousButton];
    [self.containerView addSubview:self.confrimButton];
    [self.containerView addSubview:self.cancelButton];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(CGSizeMake(BILIWIDTH(300), BILIHEIGHT(300)));
    }];
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [_confrimButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_calendar).offset(BILIWIDTH(-10));
        make.bottom.equalTo(_calendar.bottom).offset(BILIHEIGHT(-5));
        make.size.equalTo(CGSizeMake(BILIWIDTH(70), BILIHEIGHT(30)));
    }];
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.bottom.equalTo(_confrimButton);
        make.right.equalTo(_confrimButton.left).offset(BILIWIDTH(-5));
    }];
    [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_calendar);
        make.top.equalTo(_calendar.top).offset(5);
        make.size.equalTo(CGSizeMake(BILIWIDTH(70), BILIHEIGHT(34)));
    }];
    [_previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_calendar);
        make.size.top.equalTo(_nextButton);
    }];
}

#pragma mark - public
- (void)pop {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    _containerView.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:kDuration animations:^{
        _containerView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:kDuration animations:^{
        _containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if ([touch.view isEqual:self]) {
        [self dismiss];
    }
}

#pragma mark - event
#pragma mark - 下个月
- (void)nextClicked:(UIButton *)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth
                                                   value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}

#pragma mark - 上个月
- (void)previousClicked:(UIButton *)sender {
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth
                                                   value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

#pragma mark - 确定
- (void)confrimClicked:(UIButton *)sender {
    if (self.block) {
        self.block([self.dateArray componentsJoinedByString:@","]);
    }
    [self dismiss];
}

#pragma mark - 取消
- (void)cancelClicked:(UIButton *)sender {
    [self dismiss];
}

#pragma mark - setter
- (void)setRepaymentDay:(NSString *)repaymentDay {
    _repaymentDay = repaymentDay;
    [self dateCompare];
    [self.calendar reloadData];
}

- (void)dateCompare {
    if (![NSString xhq_notEmpty:self.repaymentDay]) {
        XHQHUDTEXT(@"未获取到还款日期");
        return;
    }
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"dd"];
    NSString *currentDay = [dateFormatter stringFromDate:date];
    BOOL isNextMonth = [currentDay integerValue] > [self.repaymentDay integerValue];
    //当前日期 > 还款日期  范围为：当前日期~下个月的还款日期
    //当前日期 < 还款日期  范围为：当前日期~还款日期
    
    //得到还款日期的时间格式 //yyyy-MM-dd
    [dateFormatter setDateFormat:@"yyyy-MM-"];
    NSString *appendStr = [dateFormatter stringFromDate:date];
    NSString *tempDay = self.repaymentDay.length == 2 ? self.repaymentDay : [@"0" stringByAppendingString:self.repaymentDay];
    NSString *repaymentDateStr = [appendStr stringByAppendingString:tempDay];
    
    //转成时间
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *repaymentDate = [dateFormatter dateFromString:repaymentDateStr];
    
    if (isNextMonth) {
        self.maximumDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth
                                                      value:1 toDate:repaymentDate options:0];
    }
    else {
        self.maximumDate = repaymentDate;
    }
    
}

#pragma mark - getter
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 3.f;
        _containerView.layer.masksToBounds = YES;
    }
    return _containerView;
}

- (FSCalendar *)calendar {
    if (!_calendar) {
        _calendar = [[FSCalendar alloc]init];
        _calendar.delegate = self;
        _calendar.dataSource = self;
        _calendar.firstWeekday = 2;
        _calendar.allowsMultipleSelection = YES;
        _calendar.placeholderType = FSCalendarPlaceholderTypeNone;
        
        _calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesDefaultCase | FSCalendarCaseOptionsWeekdayUsesUpperCase;
        _calendar.appearance.headerDateFormat = @"yyyy年MM月";
        _calendar.appearance.todayColor = [UIColor xhq_red];
        _calendar.appearance.selectionColor = [UIColor xhq_base];
        _calendar.appearance.headerMinimumDissolvedAlpha = 0;
        _calendar.appearance.headerTitleColor = [UIColor xhq_base];
        _calendar.appearance.weekdayTextColor = [UIColor xhq_base];
    }
    return _calendar;
}

- (UIButton *)nextButton {
    if (!_nextButton) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        [_nextButton xhq_addTarget:self action:@selector(nextClicked:)];
    }
    return _nextButton;
}

- (UIButton *)previousButton {
    if (!_previousButton) {
        _previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
        [_previousButton xhq_addTarget:self action:@selector(previousClicked:)];
    }
    return _previousButton;
}

- (UIButton *)confrimButton {
    if (!_confrimButton) {
        _confrimButton = [UIButton xhq_buttonFrame:CGRectZero
                                           bgColor:[UIColor xhq_base]
                                        titleColor:[UIColor whiteColor]
                                       borderWidth:0
                                       borderColor:nil
                                      cornerRadius:1
                                               tag:0
                                            target:self
                                            action:@selector(confrimClicked:)
                                             title:@"确定"];
        _confrimButton.xhqFont = [UIFont xhq_font14];
    }
    return _confrimButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton xhq_buttonFrame:CGRectZero
                                          bgColor:[UIColor clearColor]
                                       titleColor:[UIColor xhq_content]
                                      borderWidth:0.4f
                                      borderColor:UIColor.xhq_content.CGColor
                                     cornerRadius:1
                                              tag:0
                                           target:self
                                           action:@selector(cancelClicked:)
                                            title:@"取消"];
        _cancelButton.xhqFont = [UIFont xhq_font14];
    }
    return _cancelButton;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
        [_dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    }
    return _dateFormatter;
}

- (NSMutableArray *)dateArray {
    if (!_dateArray) {
        _dateArray = [[NSMutableArray alloc]init];
    }
    return _dateArray;
}

#pragma mark - FSCalendarDataSource
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar {
    return [NSDate date];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar {
    return self.maximumDate;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date {
    if ([self.gregorian isDateInToday:date]) {
        return @"今天";
    }
    return nil;
}

#pragma mark - FSCalendarDelegate
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    if (![self.dateArray containsObject:dateStr]) {
        [self.dateArray addObject:dateStr];
    }
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    NSString *dateStr = [self.dateFormatter stringFromDate:date];
    if ([self.dateArray containsObject:dateStr]) {
        [self.dateArray removeObject:dateStr];
    }
}

@end
