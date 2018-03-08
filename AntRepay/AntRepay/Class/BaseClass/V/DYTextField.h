//
//  DYTextField.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/23.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DYTextFieldBlock)();

@interface DYTextField : UITextField

@property (nonatomic, strong) UIImage *leftImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, assign) CGFloat leftViewWidth;

@property (nonatomic, assign) BOOL showClickSelectButton;
@property (nonatomic, assign) BOOL showTimerButton;

@property (nonatomic, assign) BOOL showDownLine;
@property (nonatomic, strong) UIColor *downLineColor;

@property (nonatomic, copy) DYTextFieldBlock block;


/**
 倒计时
 */
- (void)countDown;

@end
