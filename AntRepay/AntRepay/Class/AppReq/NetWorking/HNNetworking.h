//
//  HNNetworking.h
//  ChoosPhotoModel
//
//  Created by user on 16/4/20.
//  Copyright © 2016年 123. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, DataReturnType) {
    DataReturnTypeData = 1, /**< 返回Data数据*/
    DataReturnTypeXml,  /**< 返回XML数据 */
    DataReturnTypeJson  /**< 返回Json数据*/
};

typedef NS_ENUM(NSInteger, RequstBodyType) {
    RequstTypePlainText = 1, /**< 普通text/html*/
    RequstBodyTypeXml, /**< XML格式 */
    RequstBodyTypeJson, /**< JSon格式*/
    RequstBodyTypeDictionaryToString, /**< 字典转字符串*/
    RequstBodyTypeString /**< 字符串*/
};
typedef void(^HNResponseSuccess)(id responseObject);
typedef void(^HNResponseFail)(NSError *error);

@interface HNNetworking : NSObject

/**
 *  GET请求
 *
 *  @param urlString      请求的url
 *  @param parameters     请求参数
 *  @param dataReturnType 请求数据类型  
 *  @param successBlock   请求成功的回调  Data类型默认已经成字典
 *  @param failureBlock   请求失败的回调
 */
+ (void)getRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                 DataReturnType:(DataReturnType) dataReturnType
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock;

/**
 *  常用GET
 *
 */
+ (void)getRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock;


/**
 *  POST请求
 *
 *  @param urlString       请求的url
 *  @param parameters      请求参数
 *  @param dataReturnType  请求数据类型
 *  @param requestBodyType 请求参数类型  默认为普通text/html
 *  @param successBlock    请求成功的回调  Data类型默认已经成字典
 *  @param failureBlock    请求失败的回调
 */
+(void)postRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                 DataReturnType:(DataReturnType) dataReturnType
                RequestBodyType:(RequstBodyType)requestBodyType
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock;

/**
 *  常用POST
 *
 */
+(void)postRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock;

/**
 *  图片上传(单张)
 *
 *  @param urlString    <#urlString description#>
 *  @param param        <#param description#>
 *  @param data         <#data description#>
 *  @param name         <#name description#>
 *  @param fileName     <#fileName description#>
 *  @param mineType     <#mineType description#>
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 */
+(void)uploadPicturesWithURLString:(NSString *)urlString
                             param:(NSDictionary *)param
                              data:(NSData *)data
                              name:(NSString *)name
                          fileName:(NSString *)fileName
                          mineType:(NSString *)mineType
                      SuccessBlock:(HNResponseSuccess)successBlock
                      FailureBlock:(HNResponseFail)failureBlock;

/**
 多张图片上传

 @param urlString <#urlString description#>
 @param param <#param description#>
 @param imageArray <#imageArray description#>
 @param name <#name description#>
 @param fileName <#fileName description#>
 @param mineType <#mineType description#>
 @param successBlock <#successBlock description#>
 @param failureBlock <#failureBlock description#>
 */
+ (void)uploadPicturesArrayWithURLString:(NSString *)urlString
                                   param:(NSDictionary *)param
                              imageArray:(NSArray *)imageArray
                                    name:(NSString *)name
                                fileName:(NSString *)fileName
                                mineType:(NSString *)mineType
                            SuccessBlock:(HNResponseSuccess)successBlock
                            FailureBlock:(HNResponseFail)failureBlock;

@end
