//
//  UIView+Ext.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)

@property (nonatomic, assign) CGFloat xhq_x;
@property (nonatomic, assign) CGFloat xhq_y;
@property (nonatomic, assign) CGFloat xhq_width;
@property (nonatomic, assign) CGFloat xhq_height;
@property (nonatomic, assign) CGFloat xhq_centerX;
@property (nonatomic, assign) CGFloat xhq_centerY;
@property (nonatomic, assign) CGFloat xhq_bottom;
@property (nonatomic, assign) CGFloat xhq_right;
@property (nonatomic, assign) CGSize xhq_size;
@property (nonatomic, assign) CGPoint xhq_origin;

@end

@interface UIView (contentMode)

- (void)xhq_setAspectFitContentMode;


@end
