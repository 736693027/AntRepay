//
//  DYMessageDetailView.h
//  YiShun
//
//  Created by 崔祥莉 on 2017/10/27.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMessageDetailView : UIView

@property (nonatomic, strong) UILabel *titleLable; //标题
@property (nonatomic, strong) UILabel *timeLabel;  //时间
@property (nonatomic, strong) UIView *lineView;    //分割线
@property (nonatomic, strong) UILabel *contentLabel; //内容


- (void)setTitle:(NSString *)title time:(NSString *)time content:(NSString *)content;

@end
