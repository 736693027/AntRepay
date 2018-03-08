//
//  DYButtonView.m
//  JuXing
//
//  Created by 崔祥莉 on 2017/9/21.
//  Copyright © 2017年 APPLE. All rights reserved.
//

#import "DYButtonView.h"

@implementation DYButtonView

-(instancetype)initWithImage:(NSString *)image title:(NSString *)title{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        [self setupUIWithImage:image title:title];
    }
    return self;
}

- (void)setupUIWithImage:(NSString *)image title:(NSString *)title{
    _imgView = [[UIImageView alloc] init];
    [self addSubview:_imgView];
    _imgView.image = kGetImage(image);
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.userInteractionEnabled = YES;
    
    _titleLabel = [Utils labelWithTitleFontSize:13 textColor:[UIColor xhq_aTitle] alignment:NSTextAlignmentCenter];
    [self addSubview:_titleLabel];
    _titleLabel.text = title;
}

@end
