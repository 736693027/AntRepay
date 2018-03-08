//
//  MyTools.h
//  HaNiuBusiness
//
//  Created by user on 16/4/22.
//  Copyright © 2016年 HaNiuTimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyTools : NSObject

/**
 *  创建按钮（常用属性）
 *
 *  @param frame        位置大小
 *  @param bgColor      背景颜色
 *  @param title        名字
 *  @param titleColor   名字颜色
 *  @param borderWidth  边框宽度
 *  @param borderColor  边框颜色
 *  @param cornerRadius 弧度大小
 *  @param tag          tag值
 *  @param vc           相应视图
 *  @param action       相应方法
 *
 *  @return             返回button
 */
+(UIButton *)buttonCreate:(CGRect)frame
               setBGColor:(UIColor *)bgColor
            setTitleColor:(UIColor *)titleColor
           setBorderWidth:(CGFloat)borderWidth
           setBorderColor:(CGColorRef)borderColor
          setCornerRadius:(CGFloat)cornerRadius
                   setTag:(NSInteger)tag
                addTarget:(id)vc
                   action:(SEL)action
                 setTitle:(NSString *)title;


/**
 *  创建标签(常用属性)
 *
 *  @param frame         位置
 *  @param text          名字
 *  @param textAlignment 名字显示位置
 *  @param bgColor       背景颜色
 *  @param textColor     字体颜色
 *  @param font          字体大小
 *
 *  @return              返回label
 */
+(UILabel *)labelCreate:(CGRect)frame
       setTextAlignment:(NSTextAlignment)textAlignment
             setBGColor:(UIColor *)bgColor
           setTextColor:(UIColor *)textColor
                setFont:(UIFont *)font
                setText:(NSString *)text;

/**
 *  masonry布局下透明背景Label创建
 *
 *  @return  返回label
 */
+(UILabel *)labelWithTextColor:(UIColor *)textColor
                       setFont:(UIFont *)font
                       setText:(NSString *)text;


/**
 *  创建输入框
 *
 *  @param frame         位置
 *  @param font          字体大小
 *  @param borderWidth   边框宽度
 *  @param borderColor   边框颜色
 *  @param cornerRadius  弧度
 *  @param returnKeyType 确定样式
 *  @param keyboardType  键盘样式
 *  @param placeholder   水印字体
 *
 *  @return              返回
 */

+(UITextField *)textFieldCreate:(CGRect)frame
                        setFont:(UIFont *)font
                     setBGColor:(UIColor *)bgColor
                 setBorderWidth:(CGFloat)borderWidth
                 setBorderColor:(CGColorRef)borderColor
                setCornerRadius:(CGFloat)cornerRadius
               setRetrunKeyType:(UIReturnKeyType)returnKeyType
                setKeyboardType:(UIKeyboardType)keyboardType
                 setPlaceholder:(NSString *)placeholder ;

/**
 *  单个按钮(无响应)警告框
 *
 *  @param title   名字
 *  @param massage 信息
 *
 *  @return        返回警告框
 */
+(UIAlertController *)alertCreateTitle:(NSString *)title
                            andMassage:(NSString *)massage;

/**
 *  单个响应警告框
 *
 *  @param title      名字
 *  @param massage    信息
 *  @param enterTitle 响应按钮名字
 *  @param handler    响应事件
 *
 *  @return           返回警告框
 */
+(UIAlertController *)alertOneAcitonCreateTitle:(NSString *)title
                                     andMassage:(NSString *)massage
                             setActionEnterText:(NSString *)enterTitle
                                 setEnterAction:(void(^)(UIAlertAction * action))handler ;

/**
 *  两个按钮(一个有相应)警告框
 *
 *  @param title       名字
 *  @param massage     信息
 *  @param enterTitle  响应按钮名字
 *  @param cancelTitle 无响应按钮名字
 *  @param handler     响应事件
 *
 *  @return            返回警告框
 */
+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))handler;

/**
 *  两个按钮警告框
 *
 *  @param title        名字
 *  @param massage      信息
 *  @param enterTitle   响应按钮名字
 *  @param cancelTitle  无响应按钮名字
 *  @param enterHandler 确认响应事件
 *  @param cancelHandler 取消响应事件
 *
 *  @return             返回警告框
 */
+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))enterHandler
                              setCancelAction:(void(^)(UIAlertAction * action))cancelHandler;

/**
 *  颜色转图片
 *
 *  @param color 颜色
 *
 *  @return      返回image
 */
+ (UIImage*)createImageWithColor:(UIColor*)color;

/**
 *  自定义轮播图小圆点图片
 *
 *  @param color 颜色
 *
 *  @return      返回image
 */
+ (UIImage*)createImageWithColor:(UIColor*)color forSize:(CGSize)size;

/**
 * 空心圆
 */


/**
 * 实心圆
 */

/**
 * 左边图片右边文字的label
 */
+(UILabel *)labelWithImage:(UIImage *)image size:(CGSize)size text:(NSString *)text font:(CGFloat)font textColor:(UIColor *)color;

/**
 *  转化富文本
 *  正常字体
 */
+ (NSMutableAttributedString *)attributeWithString:(NSString *)string
                                             range:(NSRange)range
                                              font:(CGFloat)font
                                         textColor:(UIColor *)color;
/**
 *  转化富文本
 *  加粗字体
 */
+ (NSMutableAttributedString *)attributeWithString:(NSString *)string
                                             range:(NSRange)range
                                              blodFont:(CGFloat)font
                                         textColor:(UIColor *)color;

/**
 *  textField
 *  正常placeHolder颜色
 */
+(UITextField *)createTextFieldWithFont:(CGFloat)font
                            placeHolder:(NSString *)placeHolder
                        placeHolderFont:(CGFloat)placeHolderFont;

/**
 *  textField
 *  正常placeHolder颜色 keyboardType
 */
+(UITextField *)createTextFieldWithFont:(CGFloat)font
                            placeHolder:(NSString *)placeHolder
                        placeHolderFont:(CGFloat)placeHolderFont
                           keyboardType:(UIKeyboardType)keyboardType;

/** lineView: 需要绘制成虚线的view
 *  lineLength: 虚线的宽度
 *  lineSpacing: 虚线的间距
 *  lineColor: 虚线的颜色
 */
+ (UIView *)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           LineColor:(UIColor *)LineColor;

@end
