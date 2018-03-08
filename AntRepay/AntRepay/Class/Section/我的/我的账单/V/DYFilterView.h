//
//  DYFilterView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYAddRepaymentView.h"

@interface DYFilterSingleView : UIView
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *lineLabel;
- (instancetype)initWithFrame:(CGRect)frame placeHolder:(NSString *)placeHolder;
@end

@interface DYFilterView : UIView
@property (nonatomic, strong) DYAddRepaymentSingleView *typeView;
@property (nonatomic, strong) DYFilterSingleView *startView;
@property (nonatomic, strong) DYFilterSingleView *endView;
@property (nonatomic, copy) void(^typeBlock)(NSString *type); // 类型选择
@property (nonatomic, copy) void(^startTimeBlock)(NSString *time,NSString *num); // 开始时间
@property (nonatomic, copy) void(^endTimeBlock)(NSString *time,NSString *num); // 结束时间
@end




