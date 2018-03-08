//
//  dialogSingleView.h
//  WeiMinJinFu
//
//  Created by 崔祥莉 on 2017/8/15.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DialogSingleView : UIView

@property (nonatomic, strong) UIView *yellowView; //消息前方小黄点
@property (nonatomic, strong) UILabel *titleLabel; //标题
@property (nonatomic, strong) UILabel *timeLabel;  //时间
@property (nonatomic, strong) UILabel *contentLable; //内容
@property (nonatomic, strong) UIView *lineView; //分割线

@end
