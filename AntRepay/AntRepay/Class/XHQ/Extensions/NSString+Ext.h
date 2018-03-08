//
//  NSString+Ext.h
//  Excellence
//
//  Created by 帝云科技 on 2017/7/4.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)


#pragma mark - 对象方法调用 （前提是字符串存在 不为空）

/*
 *  对象方法去判断的前提是对象必须存在不为nil
 *  如果为nil的话就不会调用对象方法 从而会出现一些错误判断
 *  优先使用类方法进行判断
 */

/**
 判断是否存在（不为nil的情况下）

 @return YES不为空 NO为空
 */
- (BOOL)xhq_notEmpty;


/**
 判断是否存在并提示 （不为nil的情况下）

 @param tip 为空时的提示语
 @return YES不为空 NO为空
 */
- (BOOL)xhq_notEmptyTip:(NSString *)tip;


/**
 手机号格式检查 （不为nil的情况下）
 
 @return YES正确 NO错误
 */
- (BOOL)xhq_phoneFormatCheck;

/**
 手机号格式检查并提示 （不为nil的情况下）

 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
- (BOOL)xhq_phoneFormatCheckTip:(NSString *)tip;


/**
 身份证号格式检查 （不为nil的情况下）
 
 @return YES正确 NO错误
 */
- (BOOL)xhq_idFormatCheck;

/**
 身份证号格式检查并提示 （不为nil的情况下）
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
- (BOOL)xhq_idFormatCheckTip:(NSString *)tip;


/**
 电子邮箱格式检查 （不为nil的情况下）
 
 @return YES正确 NO错误
 */
- (BOOL)xhq_emailFormatCheck;

/**
 电子邮箱格式检查并提示 （不为nil的情况下）
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
- (BOOL)xhq_emailFormatCheckTip:(NSString *)tip;


/**
 银行卡号格式检查 （不为nil的情况下）

 @return YES正确 NO错误
 */
- (BOOL)xhq_bankCardFormatCheck;

/**
 银行卡号格式检查并提示 （不为nil的情况下）
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
- (BOOL)xhq_bankCardFormatCheckTip:(NSString *)tip;


/**
 中文姓名格式检查 （不为nil的情况下）
 
 @return YES正确 NO错误
 */
- (BOOL)xhq_cnNameFormatCheck;

/**
 中文姓名格式检查并提示 （不为nil的情况下）
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
- (BOOL)xhq_cnNameFormatCheckTip:(NSString *)tip;


/**
 隐藏手机号中间四位
 */
- (instancetype)xhq_hiddenPhoneFormat;

/**
 时间戳转化为时间

 @param formatter 格式
 @return 时间格式 (eg. 2008-08-25)
 */
- (instancetype)xhq_timeIntervalToStringFromatter:(NSString *)formatter;


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - 类方法调用


/**
 判断是否存在
 
 @return YES不为空 NO为空
 */
+ (BOOL)xhq_notEmpty:(NSString *)string;

/**
 判断是否存在并提示
 
 @param tip 为空时的提示语
 @return YES不为空 NO为空
 */
+ (BOOL)xhq_notEmpty:(NSString *)string tip:(NSString *)tip;


/**
 手机号格式检查并提示
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
+ (BOOL)xhq_phoneFormatCheck:(NSString *)string tip:(NSString *)tip;


/**
 身份证号格式检查并提示
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
+ (BOOL)xhq_idFormatCheck:(NSString *)string tip:(NSString *)tip;


/**
 电子邮箱格式检查并提示
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
+ (BOOL)xhq_emailFormatCheck:(NSString *)string tip:(NSString *)tip;


/**
 银行卡号格式检查并提示
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
+ (BOOL)xhq_bankCardFormatCheck:(NSString *)string tip:(NSString *)tip;


/**
 中文姓名格式检查并提示
 
 @param tip 格式不正确的提示语
 @return YES正确 NO错误
 */
+ (BOOL)xhq_cnNameFormatCheck:(NSString *)string tip:(NSString *)tip;


/**
 MD5加密

 @param string 加密前
 @return 加密后
 */
+ (NSString *)xhq_MD5Encryption:(NSString *)string;

/**
 判断字符串是否为空

 @return YES不为空 NO为空
 */
+ (BOOL)xhq_notNULL:(NSString *)str;

+ (instancetype)xhq_nilToInstance:(NSString *)str;

@end



/**
 url
 */
@interface NSString (XHQ_URL)

/**
 url解码
 */
+ (NSString*)xhq_URLDecodedString:(NSString*)str;


/**
 url编码
 */
+ (NSString *)xhq_URLEncodedString:(NSString *)str;

@end
