//
//  Utils.h
//  Medical_Wisdom
//
//  Created by Mac on 14-1-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
//#import "DYLoginViewController.h"

/***************************************************************************
 *
 * 工具类
 *
 ***************************************************************************/

@class AppDelegate;
@class UserInfo;

@interface Utils : NSObject

/*
 AppDelegate
 */

+(AppDelegate *_Nullable)applicationDelegate;

+ (UIImageView *_Nullable)imageViewWithFrame:(CGRect)frame
                                   withImage:(UIImage *_Nullable)image;

+ (UIImageView *_Nullable)imageViewWithImage:(UIImage *_Nullable)image;

+ (UIImageView *_Nullable)imageView;

+ (UILabel *_Nullable)labelWithFrame:(CGRect)frame
                           withTitle:(NSString *_Nullable)title
                       titleFontSize:(CGFloat )font
                           textColor:(UIColor *_Nullable)color
                     backgroundColor:(UIColor *_Nullable)bgColor
                           alignment:(NSTextAlignment)textAlignment;

+ (UILabel *_Nullable)labelWithTitle:(NSString *_Nullable)title
                       titleFontSize:(CGFloat )font
                           textColor:(UIColor *_Nullable)color
                     backgroundColor:(UIColor *_Nullable)bgColor
                           alignment:(NSTextAlignment)textAlignment;
/**
 *  一般的label
 */
+ (UILabel *_Nullable)labelWithTitleFontSize:(CGFloat )font
                           textColor:(UIColor *_Nullable)color
                           alignment:(NSTextAlignment)textAlignment;

/**
 *  加粗的label
 */
+ (UILabel *_Nullable)labelWithTitleBlodFontSize:(CGFloat )font
                                   textColor:(UIColor *_Nullable)color
                                   alignment:(NSTextAlignment)textAlignment;

+ (NSString *_Nullable)shiJianChuo:(NSString *_Nullable)timeStr;

+ (NSString *_Nullable)shiJianChuoJingQue:(NSString *_Nullable)timeStr
                                    style:(NSString *_Nullable)style;

- (void)requestDataWithURL:(NSString *_Nullable)urlStr
                   success:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                     falue:(void (^_Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))falue;

+ (UIBarButtonItem *_Nullable)initUILeftAddTarget:(id _Nullable )selfes
                                       leftaction:(SEL _Nullable )action
                                   rightAddTarget:(id _Nullable )rightSelfes rightaction:(SEL _Nullable )rightAction rightImage:(UIImage *_Nullable)rightImage leftImage:(UIImage *_Nullable)leftImage frame:(CGRect)frame;
#pragma mark - btnCreate
+ (void)buttonShuXingSetting:(UIButton *_Nullable)btn;

+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                                  frame:(CGRect)btnFrame
                        backgroundColor:(UIColor*_Nullable)bgColor
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font;

+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font;

+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor;

/**
 * 带事件的button
 */
+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                 action:(SEL _Nullable )action
                                 target:(id _Nullable )target
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor;

/**
 * 带渐变色及事件的button
 */
+(UIButton *_Nullable)createJianBianBtnWithType:(UIButtonType)btnType
                                          frame:(CGRect)btnFrame
                                 action:(SEL _Nullable )action
                                 target:(id _Nullable )target
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor;

+ (UITableView *_Nullable)setTableViewWithFrame:(CGRect)rect
                               uitableViewStyle:(UITableViewStyle)style ;

/** 正则表达式邮箱判断 */
+(BOOL)isValidateEmail:(NSString *_Nullable)email;

/** 正则表达式身份证号判断 */
+ (BOOL) validateIdentityCard: (NSString *_Nullable)identityCard;

/** 正则表达式银行卡号判断 */
+ (BOOL) checkCardNo:(NSString*_Nullable) cardNo;

/** 正则表达式手机号码判断 */
+ (BOOL)validatePhone:(NSString *_Nullable)phone;

/** 是否是汉字 */
+ (BOOL)isChinese:(NSString *_Nullable)string;

/**
 *  输入限制
 *
 *  @param number <#number description#>
 *  @param limit  <#limit description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)validateInput:(NSString*_Nullable)number limit:(NSString *_Nullable)limit;

/** 空字符串的判断 */
+ (BOOL)isNull:(id _Nullable )object;

/** md5加密 */
+ (NSString *_Nullable)md5:(NSString *_Nullable)str;

+ (NSString *_Nullable)timeWithTimeIntervalString:(NSString *_Nullable)timeString
                                           format:(NSString *_Nullable)format;

+ (NSString *_Nullable)ChangeStringTimeFormat:(NSString *_Nullable)string
                                withFormatter:(NSString *_Nullable)dateFormat ;

+(void)setTextColor:(UILabel *_Nullable)label
         FontNumber:(id _Nullable )font
           AndRange:(NSRange)range
           AndColor:(UIColor *_Nullable)vaColor;

+ (UIView *_Nullable)setSearchBarWithnavigationItem:(UIBarButtonItem *_Nullable)rightBarButtonItem

                                            navView:(UIView *_Nullable)navTitleView
                                    placeholder:(NSString *_Nullable)placeholder
                            rightBarButtonItemTitle:(NSString *_Nullable)item
                                             target:(id _Nullable )targetSelf
                                             action:(SEL _Nullable )clickAction;

+ (void)getTimeWithButton:(UIButton *_Nullable)getCodeBtn;

/**
 *  单个按钮(无响应)警告框
 *
 *  @param title   名字
 *  @param massage 信息
 *
 *  @return        返回警告框
 */
+(UIAlertController *_Nullable)alertCreateTitle:(NSString *_Nullable)title andMassage:(NSString *_Nullable)massage;

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
+(UIAlertController *_Nullable)alertOneAcitonCreateTitle:(NSString *_Nullable)title
                                     andMassage:(NSString *_Nullable)massage
                             setActionEnterText:(NSString *_Nullable)enterTitle
                                 setEnterAction:(void(^_Nullable)(UIAlertAction * _Nullable action))handler ;

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
+(UIAlertController *_Nullable)alertActionCreateTitle:(NSString *_Nullable)title
                                  andMassage:(NSString *_Nullable)massage
                          setActionEnterText:(NSString *_Nullable)enterTitle
                         setActionCancelText:(NSString *_Nullable)cancelTitle
                              setEnterAction:(void(^_Nullable)(UIAlertAction * _Nullable action))handler;

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

+(UIAlertController *_Nullable)alertActionCreateTitle:(NSString *_Nullable)title
                                  andMassage:(NSString *_Nullable)massage
                          setActionEnterText:(NSString *_Nullable)enterTitle
                         setActionCancelText:(NSString *_Nullable)cancelTitle
                              setEnterAction:(void(^_Nullable)(UIAlertAction * _Nullable action))enterHandler
                             setCancelAction:(void(^_Nullable)(UIAlertAction * _Nullable action))cancelHandler ;



/// 获取当前时间的 时间戳
+(NSInteger)getNowTimestamp;

///将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *_Nullable)formatTime andFormatter:(NSString *_Nullable)format;

/// 将某个时间戳转化成 时间
+(NSString *_Nullable)timestampSwitchTime:(NSInteger)timestamp andFormatter:(NSString *_Nullable)format;

/// 将豪秒数转化为时间
+ (NSString *_Nullable)getWorkTimeByString:(NSString *_Nonnull)time;

@end
