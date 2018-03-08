//
//  DYAppCertification.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/11/27.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYAppCertification.h"

@interface DYAppCertification ()

@property (nonatomic, assign, readwrite) BOOL isIdentity;
@property (nonatomic, assign, readwrite) BOOL isImages;
@property (nonatomic, assign, readwrite, getter=isUsed) BOOL used;
@property (nonatomic, strong, readwrite) NSString *unUsedMessage;

@end

@implementation DYAppCertification
{
    dispatch_group_t _group;
}


XHQ_SHARED_M(DYAppCertification)


- (void)certificationCompletion:(DYAppCertificationBlock)completion {
//    __block BOOL identity, images;
//    _group = dispatch_group_create();
//    dispatch_group_enter(_group);
    __block NSInteger comIndex = 0;
    [self realnameReqCompletion:^(BOOL isIdentity) {
        self.isIdentity = isIdentity;
        comIndex ++;
        XHQ_Log(@"~~comIndex~~: %ld", comIndex);
        if (comIndex == 2) {
            comIndex = 0;
            if (completion) {
                completion(self.isIdentity, self.isImages);
            }
        }
//        dispatch_group_leave(_group);
    }];
//    dispatch_group_enter(_group);
    [self imagesReqCompletion:^(BOOL isImages) {
        self.isImages = isImages;
        comIndex ++;
        if (comIndex == 2) {
            comIndex = 0;
            if (completion) {
                completion(self.isIdentity, self.isImages);
            }
        }
//        dispatch_group_leave(_group);
    }];
    
//    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
//        if (completion) {
//            completion(self.isIdentity, self.isImages);
//        }
//    });
    
}

//真实身份认证
- (void)realnameReqCompletion:(void (^)(BOOL isIdentity))completion {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_aleadyShiMing param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (completion) {
                completion(DYAPPREQSUCCESS);
            }
        }
        else {
            if (completion) {
                completion(NO);
            }
        }
    }];
}

//上传图片认证
- (void)imagesReqCompletion:(void (^)(BOOL isImages))completion  {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_auth_get_image param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *images = responseObject[@"image"];
                BOOL res = [self checkImages:images];
                if (completion) {
                    completion(res);
                }
            }else {
                if (completion) {
                    completion(NO);
                }
            }
        }else {
            if (completion) {
                completion(NO);
            }
        }
    }];
}

- (BOOL)checkImages:(NSDictionary *)images {
    NSString *idcard_positive = images[@"idcard_positive"];
    NSString *idcard_opposite = images[@"idcard_opposite"];
    NSString *idcard_hold = images[@"idcard_hold"];
    NSString *bank_positive = images[@"bank_positive"];
    NSString *bank_opposite = images[@"bank_opposite"];
    NSString *bank_hold = images[@"bank_hold"];
    
    if ([NSString xhq_notEmpty:idcard_positive] &&
        [NSString xhq_notEmpty:idcard_opposite] &&
        [NSString xhq_notEmpty:idcard_hold] &&
        [NSString xhq_notEmpty:bank_positive] &&
        [NSString xhq_notEmpty:bank_opposite] &&
        [NSString xhq_notEmpty:bank_hold]) {
        return YES;
    }
    return NO;
}

//检测是否购买使用权
- (void)usedReqCompletion:(void(^)(BOOL isUsed))completion {
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq GET:_url_used_check param:param callBack:^(id responseObject, NSError *error) {
        if (!error) {
            self.used = DYAPPREQSUCCESS;
            self.unUsedMessage = responseObject[@"message"];
            if (completion) {
                completion(DYAPPREQSUCCESS);
            }
        }else {
            self.used = NO;
            if (completion) {
                completion(NO);
            }
        }
    }];
}

@end
