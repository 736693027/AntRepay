//
//  DYLoginView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/10.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYLoginView : UIView
@property (nonatomic, copy) void(^closeBlock)(void);
@property (nonatomic, copy) void(^loginBlock)(NSString *, NSString *);
@property (nonatomic, copy) void(^registerBlock)(void);
@property (nonatomic, copy) void(^forgetPwdBlock)(void);
@end
