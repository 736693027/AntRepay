//
//  JWAlertTool.m
//  JWGeneral
//
//  Created by 帝云科技 on 2017/4/12.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "JWAlertTool.h"

@implementation JWAlertTool

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


@end
