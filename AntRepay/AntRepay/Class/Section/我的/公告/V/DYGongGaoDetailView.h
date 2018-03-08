//
//  DYGongGaoDetailView.h
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYGongGaoDetailView : UIView
@property (nonatomic, strong) UIScrollView *myScrollView;
@property (nonatomic, strong) UILabel *titleLable; //标题
@property (nonatomic, strong) UILabel *timeLabel;  //时间
@property (nonatomic, strong) UIWebView *webView;


- (void)setTitle:(NSString *)title time:(NSString *)time;

@end
