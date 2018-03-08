//
//  DYButtonView.h
//  JuXing
//
//  Created by 崔祥莉 on 2017/9/21.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYButtonView : UIView

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
-(instancetype)initWithImage:(NSString *)image title:(NSString *)title;

@end
