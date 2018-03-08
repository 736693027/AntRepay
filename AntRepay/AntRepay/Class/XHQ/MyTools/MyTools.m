//
//  MyTools.m
//  HaNiuBusiness
//
//  Created by user on 16/4/22.
//  Copyright © 2016年 HaNiuTimes. All rights reserved.
//

#import "MyTools.h"


@implementation MyTools

+(UIButton *)buttonCreate:(CGRect)frame
               setBGColor:(UIColor *)bgColor
            setTitleColor:(UIColor *)titleColor
           setBorderWidth:(CGFloat)borderWidth
           setBorderColor:(CGColorRef)borderColor
          setCornerRadius:(CGFloat)cornerRadius
                   setTag:(NSInteger)tag
                addTarget:(id)vc
                   action:(SEL)action
                 setTitle:(NSString *)title{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame               = frame;
    if (bgColor) {
    button.backgroundColor     = bgColor;
    }
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (titleColor) {
        [button setTitleColor:titleColor forState:UIControlStateNormal];
    }
    if (tag >=0) {
    button.tag                 = tag;
    }
    if (action) {
        [button addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (borderColor) {
    button.layer.borderWidth   = borderWidth;
    button.layer.borderColor   = borderColor;
    }
    if (borderWidth) {

    }
    if (cornerRadius) {
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius  = cornerRadius;
    }
    
    return button;
    
}

//创建标签
+(UILabel *)labelCreate:(CGRect)frame
       setTextAlignment:(NSTextAlignment)textAlignment
             setBGColor:(UIColor *)bgColor
           setTextColor:(UIColor *)textColor
                setFont:(UIFont *)font
                setText:(NSString *)text{
    
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    if (text) {
        label.text            = text;
    }
    if (textColor) {
        label.textColor       = textColor;
    }
    if (textAlignment) {
        label.textAlignment   = textAlignment;
    }
    if (font) {
        label.font            = font;
    }

    return label;
}

+(UILabel *)labelWithTextColor:(UIColor *)textColor
                       setFont:(UIFont *)font
                       setText:(NSString *)text {
    return [self labelCreate:CGRectZero
            setTextAlignment:0
                  setBGColor:[UIColor clearColor]
                setTextColor:textColor
                     setFont:font
                     setText:text];
}

+(UILabel *)labelWithImage:(UIImage *)image size:(CGSize)size text:(NSString *)text font:(CGFloat)font textColor:(UIColor *)color{
    UILabel *label = [[UILabel alloc] init];
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    attachment.bounds = CGRectMake(0, 0, size.width, size.height);
    label.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text];
    [attribute addAttributes:@{NSFontAttributeName:kFont(font),NSForegroundColorAttributeName:color} range:NSMakeRange(0, text.length)];
    [attribute insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment] atIndex:0];
    return label;
}

+(UIAlertController *)alertCreateTitle:(NSString *)title
                            andMassage:(NSString *)massage {
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:nil setActionCancelText:@"确定" setEnterAction:nil];
}

+(UIAlertController *)alertOneAcitonCreateTitle:(NSString *)title
                                     andMassage:(NSString *)massage
                             setActionEnterText:(NSString *)enterTitle
                                 setEnterAction:(void(^)(UIAlertAction * action))handler {
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:enterTitle setActionCancelText:nil setEnterAction:handler];
}


+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))handler {
    
//    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
//                                                                    message:massage preferredStyle:UIAlertControllerStyleAlert];
//    
//    if (cancelTitle) {
//        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelTitle
//                                                                style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:actionCancel];
//    }
//    
//    if (enterTitle) {
//        UIAlertAction * actionEnter = [UIAlertAction actionWithTitle:enterTitle
//                                               style:UIAlertActionStyleDestructive
//                                             handler:handler];
//        [alert addAction:actionEnter];
//    }
//    
//    return alert;
    
    return [self alertActionCreateTitle:title andMassage:massage setActionEnterText:enterTitle setActionCancelText:cancelTitle setEnterAction:handler setCancelAction:nil];
}

+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))enterHandler
                             setCancelAction:(void(^)(UIAlertAction * action))cancelHandler {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:massage preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction * actionCancel = [UIAlertAction actionWithTitle:cancelTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:cancelHandler];
        [alert addAction:actionCancel];
    }
    
    if (enterTitle) {
        UIAlertAction * actionEnter = [UIAlertAction actionWithTitle:enterTitle
                                                               style:UIAlertActionStyleDestructive
                                                             handler:enterHandler];
        [alert addAction:actionEnter];
    }
    
    return alert;
    
}

+(UITextField *)textFieldCreate:(CGRect)frame
                        setFont:(UIFont *)font
                     setBGColor:(UIColor *)bgColor
                 setBorderWidth:(CGFloat)borderWidth
                 setBorderColor:(CGColorRef)borderColor
                setCornerRadius:(CGFloat)cornerRadius
               setRetrunKeyType:(UIReturnKeyType)returnKeyType
                setKeyboardType:(UIKeyboardType)keyboardType
                 setPlaceholder:(NSString *)placeholder {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    
    textField.font                = font;
    textField.backgroundColor     = bgColor;
    if (borderColor) {

    textField.layer.borderColor   = borderColor;
    textField.layer.borderWidth   = borderWidth;

    }
    if (cornerRadius > 0) {
        
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius  = cornerRadius;
        
    }
    
    textField.placeholder         = placeholder;
    textField.returnKeyType       = returnKeyType;
    textField.keyboardType        = keyboardType;

    return textField;
    
}

+ (UIImage*)createImageWithColor:(UIColor*)color {
    
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage*)createImageWithColor:(UIColor*)color forSize:(CGSize)size{
    if (size.width <= 0 || size.height<= 0 )
    {
        return nil;
    }
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (NSMutableAttributedString *)attributeWithString:(NSString *)string
                                             range:(NSRange)range
                                              font:(CGFloat)font
                                         textColor:(UIColor *)color{
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
    [attribute addAttribute:NSFontAttributeName value:kFont(font) range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attribute;
}

+ (NSMutableAttributedString *)attributeWithString:(NSString *)string
                                             range:(NSRange)range
                                          blodFont:(CGFloat)font
                                         textColor:(UIColor *)color{
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:string];
    [attribute addAttribute:NSFontAttributeName value:kBlodFont(font) range:range];
    [attribute addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attribute;
}

+(UITextField *)createTextFieldWithFont:(CGFloat)font
                            placeHolder:(NSString *)placeHolder
                        placeHolderFont:(CGFloat)placeHolderFont{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = kFont(font);
    textField.placeholder = placeHolder;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [str addAttributes:@{NSFontAttributeName:kFont(placeHolderFont)} range:NSMakeRange(0, placeHolder.length)];
    textField.attributedPlaceholder = str;
    return textField;
}

+(UITextField *)createTextFieldWithFont:(CGFloat)font
                            placeHolder:(NSString *)placeHolder
                        placeHolderFont:(CGFloat)placeHolderFont
                           keyboardType:(UIKeyboardType)keyboardType{
    UITextField *textField = [[UITextField alloc] init];
    textField.font = kFont(font);
    textField.placeholder = placeHolder;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:placeHolder];
    [str addAttributes:@{NSFontAttributeName:kFont(placeHolderFont)} range:NSMakeRange(0, placeHolder.length)];
    textField.attributedPlaceholder = str;
    textField.keyboardType = keyboardType;
    return textField;
}

+ (UIView *)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           LineColor:(UIColor *)LineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:LineColor.CGColor];
    // 设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path]; CGPathRelease(path);
    // 把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    return lineView;
}

@end
