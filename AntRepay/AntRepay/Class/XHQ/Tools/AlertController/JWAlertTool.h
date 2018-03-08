//
//  JWAlertTool.h
//  JWGeneral
//
//  Created by 帝云科技 on 2017/4/12.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#pragma mark - Controller

//双按钮响应警告框
#define JWALERT_TWO_ACTION_SHOW(title,msg,enter,cancle,enterMethod,cancelMethod) [self presentViewController:\
[JWAlertTool alertActionCreateTitle:title andMassage:msg setActionEnterText:enter setActionCancelText:cancle setEnterAction:^(UIAlertAction *action) {\
enterMethod;\
} setCancelAction:^(UIAlertAction *action) {\
cancelMethod;\
}] animated:YES completion:nil]

//双按钮单个响应警告框
#define JWALERT_TWO_ONE_ACTION_SHOW(title,msg,enter,cancle,enterMethod)  JWALERT_TWO_ACTION_SHOW(title,msg,enter,cancle,enterMethod,nil)

//单个响应按钮警告框
#define JWALERT_ONE_ACTION_SHOW(title,msg,enter,enterMethod) \
JWALERT_TWO_ONE_ACTION_SHOW(title,msg,enter,nil,enterMethod)

//单个无响应警告框
#define JWALERT_NO_ACTION_SHOW(title,msg) \
JWALERT_TWO_ONE_ACTION_SHOW(title,msg,nil,@"确定",nil)

//请求失败提示消息警告框
#define XHQALERTMESSAGE \
JWALERT_NO_ACTION_SHOW(@"提示",responseObject[@"message"]);

#pragma mark - View (must be use 'parentController')

//两个按钮响应警告框
#define JWALERT_TWO_ACTION_SHOW_VIEW(title,msg,enter,cancle,enterMethod,cancelMethod) [self.parentController presentViewController:\
[MyTools alertActionCreateTitle:title andMassage:msg setActionEnterText:enter setActionCancelText:cancle setEnterAction:^(UIAlertAction *action) {\
enterMethod;\
} setCancelAction:^(UIAlertAction *action) {\
cancelMethod;\
}] animated:YES completion:nil]

//两个按钮一个响应警告框
#define JWALERT_TWO_ONE_ACTION_SHOW_VIEW(title,msg,enter,cancle,enterMethod) JWALERT_TWO_ACTION_SHOW_VIEW(title,msg,enter,cancle,enterMethod,nil)

//单个响应按钮警告框
#define JWALERT_ONE_ACTION_SHOW_VIEW(title,msg,enter,enterMethod) \
JWALERT_TWO_ONE_ACTION_SHOW_VIEW(title,msg,enter,nil,enterMethod)

//单个无响应警告框
#define JWALERT_NO_ACTION_SHOW_VIEW(title,msg) \
JWALERT_TWO_ONE_ACTION_SHOW_VIEW(title,msg,nil,@"确定",nil)


@interface JWAlertTool : NSObject

/**
 *  单个按钮(无响应)警告框
 *
 *  @param title   名字
 *  @param massage 信息
 *
 *  @return alert
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
 *  @return alert
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
 *  @return alert
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
 *  @return alert
 */
+(UIAlertController *)alertActionCreateTitle:(NSString *)title
                                  andMassage:(NSString *)massage
                          setActionEnterText:(NSString *)enterTitle
                         setActionCancelText:(NSString *)cancelTitle
                              setEnterAction:(void(^)(UIAlertAction * action))enterHandler
                             setCancelAction:(void(^)(UIAlertAction * action))cancelHandler;

@end
