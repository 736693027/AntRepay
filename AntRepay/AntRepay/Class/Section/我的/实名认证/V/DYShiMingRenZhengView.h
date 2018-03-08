//
//  DYShiMingRenZhengView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^issuingBankButtonBlock)(void);
typedef void(^provinceButtonBlock)(void);
typedef void(^cityButtonBlock)(void);
@class DYRenZhengSingleView;
@interface DYShiMingRenZhengView : UIView

@property (nonatomic, strong) DYRenZhengSingleView *bankNameView;
@property (nonatomic, strong) DYRenZhengSingleView *shengView;
@property (nonatomic, strong) DYRenZhengSingleView *shiView;

@property (nonatomic, strong) UIButton *codeBtn; // 验证码
@property (nonatomic, copy) issuingBankButtonBlock issuingBlock; //发卡银行
@property (nonatomic, copy) provinceButtonBlock provinceBlock;
@property (nonatomic, copy) cityButtonBlock cityBlock;

@property (nonatomic, copy) void(^codeBlock)(NSString *phone);
@property (nonatomic, copy) void(^submitBlock)(NSString *realname,NSString *idcard,NSString *address,NSString *bank_num,NSString *bank_name,NSString *branch_name,NSString *province,NSString *city,NSString *phone, NSString *code); // 提交

@end


@interface DYShiMingTitleView : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@property (nonatomic, strong) UILabel *label;
@end


@interface DYRenZhengSingleView : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder;
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIButton *xiaLaBtn;

@end

typedef void(^DYAntRealnameViewBlock)(NSString *name, NSString *idStr, NSString *codeStr);
typedef void(^DYAntRealnameViewCodeBlock)(NSString *phone);
/**
 蚂蚁还呗实名认证
 */
@interface DYAntRealnameView : UIView

@property (nonatomic, copy) DYAntRealnameViewBlock block;
@property (nonatomic, copy) DYAntRealnameViewCodeBlock codeBlock;
@property (nonatomic, strong) UIButton *codeButton;

@end
