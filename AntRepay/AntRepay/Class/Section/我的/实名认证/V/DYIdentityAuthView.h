//
//  DYIdentityAuthView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYIdentityAuthView : UIView

@property (nonatomic, strong) UIButton *nextBtn;  // 提交按钮
@property (nonatomic, copy) void(^firstBlock)(UIImage *image);
@property (nonatomic, copy) void(^secondBlock)(UIImage *image);
@property (nonatomic, copy) void(^thirdBlock)(UIImage *image);
@property (nonatomic, copy) void(^forthBlock)(UIImage *image);
@property (nonatomic, copy) void(^fifthBlock)(UIImage *image);
@property (nonatomic, copy) void(^sixBlock)(UIImage *image);

@property (nonatomic, copy) void(^nextBlock)(UIImage *firstImg,UIImage *secondImg,UIImage *thirdImg,UIImage *forthImg,UIImage *fifthImg,UIImage *sixImg);

// 图片
- (void)setValueWithDictionary:(NSDictionary *)dictionary;

@end

@interface DYIdentityAuthSingleView : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *label;
@end
