//
//  DYPageTitleView.h
//  Huixin
//
//  Created by 帝云科技 on 2017/7/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DYPageTitleViewSelectedBlcok)(NSInteger selectedIndex);
@interface DYPageTitleView : UIView

@property (nonatomic,strong) UIColor *titleNomalColor;  /**<字体普通颜色  默认：黑色*/

@property (nonatomic,strong) UIColor *titleSelectedColor; /**<字体选中颜色  默认：黑色*/

@property (nonatomic,strong) UIColor *lineColor;  /**<下划线颜色  默认：主色调*/

@property (nonatomic,strong) UIFont  *titleFont;  /**<字体大小  默认：16*/

@property (nonatomic,assign) NSInteger selectedIndex; /**<被选中的*/

@property (nonatomic, copy) DYPageTitleViewSelectedBlcok block;  /**<点击回调*/

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)array;

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end
