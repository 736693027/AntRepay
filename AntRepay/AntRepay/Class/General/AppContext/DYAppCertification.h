//
//  DYAppCertification.h
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/27.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DYAppCertificationBlock)(BOOL isIdentity, BOOL isImages);

@interface DYAppCertification : NSObject

@property (nonatomic, assign, readonly) BOOL isIdentity;
@property (nonatomic, assign, readonly) BOOL isImages;


/**
 检测是否购买使用权
 */
@property (nonatomic, assign, readonly, getter=isUsed) BOOL used;

/**
 未购买使用权的提示语
 */
@property (nonatomic, strong, readonly) NSString *unUsedMessage;

XHQ_SHARED_H(DYAppCertification)


/**
 实名认证
 @param completion 图片认证和姓名认证
 */
- (void)certificationCompletion:(DYAppCertificationBlock)completion;

/**
 检测是否购买使用权
 @param completion 回调 yes 已购买
 */
- (void)usedReqCompletion:(void(^)(BOOL isUsed))completion;

@end
