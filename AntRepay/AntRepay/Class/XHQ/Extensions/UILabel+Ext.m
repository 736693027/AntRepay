//
//  UILabel+Ext.m
//  Excellence
//
//  Created by 帝云科技 on 2017/6/19.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "UILabel+Ext.h"
#import <objc/runtime.h>

@implementation UILabel (Ext)

+ (instancetype)xhq_layoutColor:(UIColor *)color
                           font:(UIFont *)font
                           text:(NSString *)text {
    return [self xhq_labelFrame:CGRectZero
                        bgColor:[UIColor clearColor]
                      textColor:color
                  textAlignment:0
                           font:font
                           text:text];
}

+ (instancetype)xhq_labelFrame:(CGRect)frame
                       bgColor:(UIColor *)bgColor
                     textColor:(UIColor *)tColor
                 textAlignment:(NSTextAlignment)alignment
                          font:(UIFont *)font
                          text:(NSString *)text {
    return ({
        UILabel *label = [[UILabel alloc]initWithFrame:frame];
        label.textColor = tColor;
        label.backgroundColor = bgColor;
        label.textAlignment = alignment;
        label.font = font;
        label.text = text;
        label;
    });
}

+ (instancetype)xhq_lineLabel {
    return ({
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor xhq_line];
        label;
    });
}


@end

@implementation UILabel (attributed)

- (void)attribute:(NSDictionary *)att range:(NSRange)range {
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attribute setAttributes:att range:range];
    [self setAttributedText:attribute];
}

- (void)lineSpace:(CGFloat)lineSpace {
    [self lineSpace:lineSpace wordSpace:0];
}

- (void)wordSpace:(CGFloat)wordSpace {
    [self lineSpace:0 wordSpace:wordSpace];
}

- (void)lineSpace:(CGFloat)lineSpace wordSpace:(CGFloat)wordSpace {
    
    NSString *string = self.text;
    
    NSMutableAttributedString *attributedString = nil;
    
    if (wordSpace > 0) {
        
        attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSKernAttributeName:@(wordSpace)}];
        
    }else {
        if (string) {
            attributedString = [[NSMutableAttributedString alloc]initWithString:string];
        }
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    if (lineSpace > 0) {
        [paragraphStyle setLineSpacing:lineSpace];
    }
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    self.attributedText = attributedString;
    
    [self sizeToFit];
}

- (void)paragraphSpace:(CGFloat)paragraphSpace {
    
    NSString *string = self.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setParagraphSpacing:paragraphSpace];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    
    self.attributedText = attributedString;
    
    [self sizeToFit];
}

@end

@implementation UILabel (customText)

/*
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class instanceClass = [self class];
        
        SEL originalSelector = @selector(setFont:);
        SEL swizzledSelector = @selector(xhq_setFont:);
        
        Method originalMethod = class_getInstanceMethod(instanceClass, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(instanceClass, swizzledSelector);
        
        BOOL isAddMethod = class_addMethod(instanceClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (isAddMethod) {
            class_replaceMethod(instanceClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)xhq_setFont:(UIFont *)font {
    UIFont *aFont = [UIFont fontWithName:@"TrebuchetMS" size:font.pointSize];
    [self xhq_setFont:aFont];
}
*/


@end
