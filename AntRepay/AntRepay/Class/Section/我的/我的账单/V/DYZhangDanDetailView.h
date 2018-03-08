//
//  DYZhangDanDetailView.h
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYZhangDanDetailView : UIView

@property (nonatomic, strong) NSArray *typeArray;

- (void)setValueWithDictionary:(NSDictionary *)dictionary;

@end



@interface DYZhangDanDetailSingleView : UIView
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end
