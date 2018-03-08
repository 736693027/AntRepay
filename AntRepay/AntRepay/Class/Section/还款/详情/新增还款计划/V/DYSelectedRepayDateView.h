//
//  DYSelectedRepayDateView.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DYSelectedRepayDateViewBlock)(NSString *datesString);
@interface DYSelectedRepayDateView : UIView

@property (nonatomic, copy) DYSelectedRepayDateViewBlock block;
@property (nonatomic, strong) NSString *repaymentDay;

- (void)pop;
- (void)dismiss;


@end

