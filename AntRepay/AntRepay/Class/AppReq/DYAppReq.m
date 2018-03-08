//
//  DYAppReq.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAppReq.h"

@implementation DYAppReq

#pragma mark - GET请求
+ (void)GET:(NSString *)urlString param:(NSDictionary *)param callBack:(DYAppReqBlock)block {
    
    [HNNetworking getRequestWithURLString:[self appending:urlString]
                               Parameters:param
                             SuccessBlock:^(id responseObject) {
                                 NSLog(@"%@", block);
                                 if (block) {
                                     block(responseObject, nil);
                                 }
                             } FailureBlock:^(NSError *error) {
                                 if (block) {
                                     block(nil, error);
                                 }
                             }];
}

#pragma mark - POST请求
+ (void)POST:(NSString *)urlString param:(NSDictionary *)param callBack:(DYAppReqBlock)block {
    
    [HNNetworking postRequestWithURLString:[self appending:urlString]
                                Parameters:param
                              SuccessBlock:^(id responseObject) {
                                  if (block) {
                                      block(responseObject, nil);
                                  }
                              } FailureBlock:^(NSError *error) {
                                  if (block) {
                                      block(nil, error);
                                  }
                              }];
}

#pragma mark - 图片上传
+ (void)dy_upload:(NSString *)urlString
             name:(NSString *)name
            image:(UIImage *)image
            param:(NSDictionary *)param
         callBack:(DYAppReqBlock)block {
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [HNNetworking uploadPicturesWithURLString:[self appending:urlString]
                                        param:param data:imageData
                                         name:name
                                     fileName:@"image.jpg"
                                     mineType:@"image/png/jpg"
                                 SuccessBlock:^(id responseObject) {
                                     if (block) {
                                         block(responseObject, nil);
                                     }
                                 } FailureBlock:^(NSError *error) {
                                     if (block) {
                                         block(nil, error);
                                     }
                                 }];
}

#pragma mark - 地址拼接
+ (NSString *)appending:(NSString *)urlString {
    
    if ([urlString hasPrefix:@"http://"] && [urlString hasSuffix:@".html"]) {
        return urlString;
    }
    
    if (![urlString hasPrefix:@"http://"]) {
        urlString = [_url_base stringByAppendingString:urlString];
    }
    
    if (![urlString hasSuffix:@".html"]) {
        urlString = [urlString stringByAppendingString:_url_end];
    }
    return urlString;
}

@end
