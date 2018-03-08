//
//  HNNetworking.m
//  ChoosPhotoModel
//
//  Created by user on 16/4/20.
//  Copyright © 2016年 123. All rights reserved.
//

#import "HNNetworking.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation HNNetworking

+(AFHTTPSessionManager *)manager {
    
   static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AFHTTPSessionManager alloc]init];
    });
    return manager;
}


+(NSDictionary *)JSONDataWithData:(id)responseObject {
    
    return [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
}

+(void)getRequestWithURLString:(NSString *)urlString
                    Parameters:(id)parameters
                  SuccessBlock:(HNResponseSuccess)successBlock
                  FailureBlock:(HNResponseFail)failureBlock {
    [self getRequestWithURLString:urlString
                       Parameters:parameters
                   DataReturnType:1
                     SuccessBlock:successBlock
                     FailureBlock:failureBlock];
}


+(void)getRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                 DataReturnType:(DataReturnType)dataReturnType
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock {
    
    AFHTTPSessionManager * manager = [self manager];
    
    // 支持https
    manager.securityPolicy.allowInvalidCertificates =  YES;
    manager.requestSerializer.timeoutInterval = 30;
    // 状态栏加载指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 网络数据形式
    switch (dataReturnType) {
        case DataReturnTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case DataReturnTypeXml: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case DataReturnTypeJson: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        default: {
            
            break;
        }
    }
    
    // 响应数据支持的类型
    [manager.responseSerializer
     setAcceptableContentTypes: [NSSet setWithObjects:
                                 @"application/json",
                                 @"text/json",
                                 @"text/javascript",
                                 @"text/html",
                                 @"text/css",
                                 @"text/plain",
                                 @"application/x-javascript",
                                 @"application/javascript",
                                 nil]];
    
    // url转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            if (dataReturnType == DataReturnTypeData) {
                successBlock([self JSONDataWithData:responseObject]);
            }else {
                successBlock(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];

}

+(void)postRequestWithURLString:(NSString *)urlString
                     Parameters:(id)parameters
                   SuccessBlock:(HNResponseSuccess)successBlock
                   FailureBlock:(HNResponseFail)failureBlock {
    [self postRequestWithURLString:urlString
                        Parameters:parameters
                    DataReturnType:1
                   RequestBodyType:1
                      SuccessBlock:successBlock
                      FailureBlock:failureBlock];
}

+(void)postRequestWithURLString:(NSString *)urlString
                      Parameters:(id)parameters
                  DataReturnType:(DataReturnType)dataReturnType
                 RequestBodyType:(RequstBodyType)requestBodyType
                    SuccessBlock:(HNResponseSuccess)successBlock
                    FailureBlock:(HNResponseFail)failureBlock {
    
    AFHTTPSessionManager * manager = [self manager];
    // 支持https
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    // 状态栏加载指示器
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    // 上传数据时body的类型
    switch (requestBodyType) {
        case RequstBodyTypeString:
            // 保持字符串样式
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString *(NSURLRequest *request, id parameters, NSError *__autoreleasing *error) {
                return parameters;
            }];
            break;
        case RequstBodyTypeDictionaryToString:
            break;
        case RequstBodyTypeJson:
            // 保持JSON格式
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        case RequstBodyTypeXml:
            manager.requestSerializer = [AFPropertyListRequestSerializer serializer];
            break;
            case RequstTypePlainText:
        default:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    manager.requestSerializer.timeoutInterval = 20.f;
    
    // 网络数据形式
    switch (dataReturnType) {
        case DataReturnTypeData: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case DataReturnTypeXml: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
        case DataReturnTypeJson: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        default: {
             manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
    }
//    ((AFJSONResponseSerializer *)manager.responseSerializer).removesKeysWithNullValues = YES;

    
    // 响应数据支持的类型
    [manager.responseSerializer
     setAcceptableContentTypes: [NSSet setWithObjects:
                                 @"application/json",
                                 @"text/json",
                                 @"text/javascript",
                                 @"text/html",
                                 @"text/css",
                                 @"text/plain",
                                 @"application/x-javascript",
                                 @"application/javascript",
                                 nil]];
    
    // url转码
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (dataReturnType == DataReturnTypeData) {
            successBlock([self JSONDataWithData:responseObject]);
        }else {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
             failureBlock(error);
        }
    }];
}

+(void)uploadPicturesWithURLString:(NSString *)urlString
                             param:(NSDictionary *)param
                              data:(NSData *)data
                              name:(NSString *)name
                          fileName:(NSString *)fileName
                          mineType:(NSString *)mineType
                      SuccessBlock:(HNResponseSuccess)successBlock
                      FailureBlock:(HNResponseFail)failureBlock {
    AFHTTPSessionManager * manager = [self manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/soap+xml" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/plain",
                                                         @"text/html",
                                                         @"application/soap+xml",
                                                         @"application/xml",nil];
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mineType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock([self JSONDataWithData:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)uploadPicturesArrayWithURLString:(NSString *)urlString
                              param:(NSDictionary *)param
                               imageArray:(NSArray *)imageArray
                               name:(NSString *)name
                           fileName:(NSString *)fileName
                           mineType:(NSString *)mineType
                       SuccessBlock:(HNResponseSuccess)successBlock
                       FailureBlock:(HNResponseFail)failureBlock {
    AFHTTPSessionManager * manager = [self manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/soap+xml" forHTTPHeaderField:@"Accept"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/json",
                                                         @"text/javascript",
                                                         @"text/plain",
                                                         @"text/html",
                                                         @"application/soap+xml",
                                                         @"application/xml",nil];
    [manager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger index = 0; index < imageArray.count; index ++) {
            NSData *data = UIImageJPEGRepresentation(imageArray[index], 0.5);
            NSString *nameString = [NSString stringWithFormat:@"%@%ld",name,index + 1];
            NSString *fileNameString = [NSString stringWithFormat:@"%@%ld.jpg",fileName,index + 1];
            [formData appendPartWithFileData:data name:nameString fileName:fileNameString mimeType:mineType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock([self JSONDataWithData:responseObject]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}


@end
