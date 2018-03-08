//
//  DYLoginSingleView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYLoginSingleView : UIView
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *lineLabel;

- (instancetype)initWithFrame:(CGRect)frame image:(NSString *)image placeHolder:(NSString *)placeHolder;
@end
