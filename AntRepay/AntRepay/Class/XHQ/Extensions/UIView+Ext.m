//
//  UIView+Ext.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "UIView+Ext.h"

@implementation UIView (Ext)

- (CGFloat)xhq_x {
    return self.frame.origin.x;
}

- (CGFloat)xhq_y {
    return self.frame.origin.y;
}

- (void)setXhq_x:(CGFloat)xhq_x {
    CGRect frame = self.frame;
    frame.origin.x = xhq_x;
    self.frame = frame;
}

- (void)setXhq_y:(CGFloat)xhq_y {
    CGRect frame = self.frame;
    frame.origin.y = xhq_y;
    self.frame = frame;
}

- (CGFloat)xhq_width {
    return self.frame.size.width;
}

- (CGFloat)xhq_height {
    return self.frame.size.height;
}

- (void)setXhq_width:(CGFloat)xhq_width {
    CGRect frame = self.frame;
    frame.size.width = xhq_width;
    self.frame = frame;
}

- (void)setXhq_height:(CGFloat)xhq_height {
    CGRect frame = self.frame;
    frame.size.height = xhq_height;
    self.frame = frame;
}

- (CGFloat)xhq_centerX {
    return self.center.x;
}

- (CGFloat)xhq_centerY {
    return self.center.y;
}

- (void)setXhq_centerX:(CGFloat)xhq_centerX {
    CGPoint center = self.center;
    center.x = xhq_centerX;
    self.center = center;
}

- (void)setXhq_centerY:(CGFloat)xhq_centerY {
    CGPoint center = self.center;
    center.y = xhq_centerY;
    self.center = center;
}

- (CGFloat)xhq_bottom {
    return (self.frame.origin.y + self.frame.size.height);
}

- (CGFloat)xhq_right {
    return (self.frame.origin.x + self.frame.size.width);
}

- (void)setXhq_bottom:(CGFloat)xhq_bottom {
    
}

- (void)setXhq_right:(CGFloat)xhq_right {
    
}

- (CGPoint)xhq_origin {
    return self.frame.origin;
}

- (CGSize)xhq_size {
    return self.frame.size;
}

- (void)setXhq_origin:(CGPoint)xhq_origin {
    CGRect frame = self.frame;
    frame.origin = xhq_origin;
    self.frame = frame;
}

- (void)setXhq_size:(CGSize)xhq_size {
    CGRect frame = self.frame;
    frame.size = xhq_size;
    self.frame = frame;
}



@end

@implementation UIView (contentMode)

- (void)xhq_setAspectFitContentMode {
    self.contentMode = UIViewContentModeScaleAspectFit;
}

@end
