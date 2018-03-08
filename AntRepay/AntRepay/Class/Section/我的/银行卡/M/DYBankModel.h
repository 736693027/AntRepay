//
//  DYBankModel.h
//  AntRepay
//
//  Created by 帝云科技 on 2018/1/3.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "DYModel.h"

@interface DYBankModel : DYModel

@property (nonatomic, strong) NSString *bank_name;
@property (nonatomic, strong) NSString *bank_num;

@end

@interface DYBankUserInfoModel : DYModel

@property (nonatomic, strong) NSString *realname;
@property (nonatomic, strong) NSString *idcard;

@end

@interface DYBankAddInputModel : DYModel

@property (nonatomic, strong) NSString *inputString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, assign) BOOL disEnabled; /**<无法编辑*/
@property (nonatomic, assign) BOOL selected; /**<下拉选择*/
@property (nonatomic, assign) BOOL countDown; /**<倒计时*/
@property (nonatomic, assign) BOOL startCountDown; /**<开始倒计时*/

@end
