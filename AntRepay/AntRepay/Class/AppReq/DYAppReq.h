//
//  DYAppReq.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "xhq_urlHeader.h"
#import "cxl_urlHeader.h"
#import "HNNetworking.h"

#define DYAPPENDING(str) [DYAppReq appending:str]
#define DYAPPREQSUCCESS [responseObject[@"status"] integerValue] == 9999

typedef void(^DYAppReqBlock)(id responseObject, NSError *error);

@interface DYAppReq : NSObject


#pragma mark - 调用
/**
 get请求
 */
+ (void)GET:(NSString *)urlString param:(NSDictionary *)param callBack:(DYAppReqBlock)block;

/**
 post请求
 */
+ (void)POST:(NSString *)urlString param:(NSDictionary *)param callBack:(DYAppReqBlock)block;

/**
 图片上传-单张
 */
+ (void)dy_upload:(NSString *)urlString
             name:(NSString *)name
            image:(UIImage *)image
            param:(NSDictionary *)param
         callBack:(DYAppReqBlock)block;

/**
 地址拼接
 */
+ (NSString *)appending:(NSString *)urlString;


/*
 
 //eg
 
XHQHUDSHOW(self.view); //加载圈
NSDictionary *param = @{@"username": _userTF.text,
@"password": _passTF.text};
[DYAppReq POST:_url_login param:param callBack:^(id responseObject, NSError *error) {
    XHQHUDHIDE(self.view); //隐藏
    if (!error) {
        if (DYAPPREQSUCCESS) { //成功判断
            XHQHUDTEXT(@"登录成功");
            //doing
        }else {
            XHQHUDMESSAGE //错误提示
        }
    }else {
        XHQHUDFAIL(self.view); //网络错误提示
    }
}];

 */
@end
