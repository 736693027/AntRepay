//
//  DYChangeCardVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYChangeCardVC.h"
#import "DYChangeCardView.h"
#import "BRPickerView.h"
#import "PGDatePicker.h"
#import "DYAddRepaymentView.h"

@interface DYChangeCardVC ()<PGDatePickerDelegate>
@property (nonatomic, strong) DYChangeCardView *cardView;
@property (nonatomic, strong) NSString *cardTermString;

@end

@implementation DYChangeCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"修改信用卡";
    _cardView = [[DYChangeCardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _cardView.cardNumView.textField.text = self.card_num;
    [self.view addSubview:_cardView];
    __weak typeof(self) weakSelf = self;
    _cardView.termBlock = ^{
        [weakSelf selectedCardTerm];
    };
    // 账单日
    _cardView.zhangDanRiBlock = ^{
        [BRStringPickerView showStringPickerWithTitle:@"请选择账单日" dataSource:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"] defaultSelValue:@"15" isAutoSelect:NO resultBlock:^(id selectValue) {
            weakSelf.cardView.zhangDanView.textField.text = selectValue;
        }];
    };
    // 还款日
    _cardView.huanKuanRiBlock = ^{
        [BRStringPickerView showStringPickerWithTitle:@"请选择还款日" dataSource:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"] defaultSelValue:@"15" isAutoSelect:NO resultBlock:^(id selectValue) {
            weakSelf.cardView.huanKuanView.textField.text = selectValue;
        }];
    };
    @weakify(self);
    // 修改
    _cardView.changeBlock = ^(NSString *idcard, NSString *CVN2, NSString *youXiaoQi, NSString *zhangDanQi, NSString *huanKuanQi) {
        @strongify(self);
        NSDictionary *param = @{
                                DY_APP_KEY_VALUE_REQ,
                                @"cardid": weakSelf.card_id,
                                @"cvn2": CVN2,
                                @"date": weakSelf.cardTermString,
                                @"statement": zhangDanQi,
                                @"repayment": huanKuanQi
                                };
        JWALERT_TWO_ONE_ACTION_SHOW(@"提示",
                                    @"确定要修改并提交当前信用卡的信息",
                                    @"确定",
                                    @"取消",
                                    [self editSubmitReq:param]);
    };
}

- (void)editSubmitReq:(NSDictionary *)param {
    XHQHUDSHOW(self.view);
    [DYAppReq POST:_url_creditCard_edit param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        responseObject[@"message"],
                                        @"确定",
                                        [self.navigationController popViewControllerAnimated:YES]);
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}

#pragma mark - 有效期选择
- (void)selectedCardTerm {
    [self.view endEditing:YES];
    DYSelectedCardTermView *termView = [[DYSelectedCardTermView alloc]init];
    [termView pop];
    termView.block = ^(NSString *year, NSString *month) {
        _cardView.youXiaoQiView.textField.text = [NSString stringWithFormat:@"%@/%@", month, year];
        self.cardTermString = [NSString stringWithFormat:@"%@%@", year, month];
    };
    return;
    
    PGDatePicker *datePicker = [[PGDatePicker alloc]init];
    datePicker.delegate = self;
    [datePicker show];
    datePicker.titleLabel.text = @"选择有效期";
    datePicker.datePickerMode = PGDatePickerModeYearAndMonth;
    datePicker.confirmButtonTextColor = [UIColor xhq_base];
    datePicker.textColorOfSelectedRow = [UIColor xhq_aTitle];
    datePicker.lineBackgroundColor = [UIColor xhq_content];
    datePicker.minimumDate = [NSDate date];
}

#pragma mark - PGDatePickerDelegate
- (void)datePicker:(PGDatePicker *)datePicker didSelectDate:(NSDateComponents *)dateComponents {
    NSString *year = [NSString stringWithFormat:@"%ld", dateComponents.year];
    NSString *month = [NSString stringWithFormat:@"%ld", dateComponents.month];
    year = [year substringFromIndex:2];
    month = month.length == 2 ? month : [@"0" stringByAppendingString:month];
    _cardView.youXiaoQiView.textField.text = [NSString stringWithFormat:@"%@/%@", month, year];
    self.cardTermString = [NSString stringWithFormat:@"%@%@", year, month];
}

@end
