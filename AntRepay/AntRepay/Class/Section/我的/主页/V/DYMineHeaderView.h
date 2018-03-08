//
//  DYMineHeaderView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/13.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYMineHeaderView : UIView
@property (nonatomic, copy) void(^iconBlock)(void);

- (void)setValueWithNickName:(NSString *)nickName phone:(NSString *)phone avatar:(NSString *)avatar;
@end
