//
//  DYForgetPwdSingleView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYForgetPwdSingleView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UITextField *textField;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title placeHolder:(NSString *)placeHolder;

@end
