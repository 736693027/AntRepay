//
//  UILabel+Ext.h
//  Excellence
//
//  Created by 帝云科技 on 2017/6/19.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Ext)

+ (instancetype)xhq_layoutColor:(UIColor *)color
                           font:(UIFont *)font
                           text:(NSString *)text;

+ (instancetype)xhq_labelFrame:(CGRect)frame
                       bgColor:(UIColor *)bgColor
                     textColor:(UIColor *)tColor
                 textAlignment:(NSTextAlignment)alignment
                          font:(UIFont *)font
                          text:(NSString *)text;

+ (instancetype)xhq_lineLabel;

@end

@interface UILabel (attributed)

- (void)attribute:(NSDictionary *)att range:(NSRange)range;

/**
 *  修改行间距
 *
 *  @param lineSpace 间距
 */
- (void)lineSpace:(CGFloat)lineSpace;

/**
 *  修改字间距
 *
 *  @param wordSpace 间距
 */
- (void)wordSpace:(CGFloat)wordSpace;

/**
 *  修改行间距与字间距
 *
 *  @param lineSpace 间距
 *  @param wordSpace 间距
 */
- (void)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace;

/**
 *  修改段落间距（\n换行）
 *
 *  @param paragraphSpace 间距
 */
- (void)paragraphSpace:(CGFloat)paragraphSpace;

@end

@interface UILabel (customText)

@end
