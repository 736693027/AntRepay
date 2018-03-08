//
//  DYShareView.h
//  Julong
//
//  Created by 帝云科技 on 2017/8/22.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DYShareType) {
    DYShareWechat, /**<微信好友*/
    DYShareCircle,  /**<朋友圈*/
    DYShareQQ
};
typedef void(^DYShareViewHandle)(DYShareType shareType);
@interface DYShareView : UIView

+ (void)shareSelectCompletion:(DYShareViewHandle)completion;

@end

@interface DYShareSelectedItem : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end
