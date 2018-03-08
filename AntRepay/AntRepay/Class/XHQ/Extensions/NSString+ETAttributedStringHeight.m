//
//  NSString+ETAttributedStringHeight.m
//  Ethome
//
//  Created by YoloMao on 15/12/24.
//  Copyright © 2015年 Whalefin. All rights reserved.
//

#import "NSString+ETAttributedStringHeight.h"

@implementation NSString (ETAttributedStringHeight)

/**
 *  得到期望高度
 *
 *  @return 期望高度字符串
 */
+ (NSString *)getSuitableHeightWithString:(NSString *)string WithWidth:(CGFloat)width WithFont:(CGFloat)font
{
    //    [self layoutIfNeeded];
    NSMutableAttributedString *attr = [self getAttributedStringWithString:string WithFont:font];
    CGRect paragraphRect = [attr boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                             options:(NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             context:nil];
    CGFloat height = ceilf(paragraphRect.size.height);
    height = ceilf(height/16) * 16;//取16的整数倍，向上取整,这里的16为一行label的高度
    NSString *heightstr = [NSString stringWithFormat:@"%f",height];
    return heightstr;
}

/**
 *  得到string的AttributedString
 *
 *  @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringWithString:(NSString *)string WithFont:(CGFloat)font
{
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange allRange = [string rangeOfString:string];
    [attr addAttribute:NSFontAttributeName
                 value:kFont(font)
                 range:allRange];
    return attr;
}

@end
