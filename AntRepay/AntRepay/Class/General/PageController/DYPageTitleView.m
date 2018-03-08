//
//  DYPageTitleView.m
//  Huixin
//
//  Created by 帝云科技 on 2017/7/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYPageTitleView.h"

@interface DYPageTitleView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UILabel *lineLabel;
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

static const NSTimeInterval kAnimationDuration = 0.3;
static const NSInteger kFixedRadix = 10000;
static const NSInteger kMostScreenDisplay = 6;

static NSString *const _image_view_bg = @"view_bg";

@implementation DYPageTitleView

- (instancetype)initWithFrame:(CGRect)frame withTitleArray:(NSArray *)array {
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = array;
        _titleNomalColor = [UIColor xhq_aTitle];
        _titleSelectedColor = [UIColor xhq_base];
        _lineColor = [UIColor xhq_base];
        _titleFont = XHQ_FONT(15);
        self.backgroundColor = [UIColor xhq_section];
        [self initUI];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.bgImageView];
    [self addSubview:self.scrollView];
    [self segmentView];
    [self.scrollView addSubview:self.lineLabel];
}

- (void)segmentView {
    
    CGFloat width = 0.0;
    NSInteger arrCount = self.dataArray.count;
    if (arrCount > kMostScreenDisplay) {
        width = CGRectGetWidth(self.bounds) / kMostScreenDisplay;
    }else {
        width = CGRectGetWidth(self.bounds) / arrCount;
    }
    self.scrollView.contentSize = CGSizeMake(arrCount *width, 0);
    
    for (NSInteger index = 0; index < arrCount; index ++) {
        UIButton *button = ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            button.tag = index + kFixedRadix;
            button.titleLabel.font = self.titleFont;
            button.frame = CGRectMake(width * index, 0, width, CGRectGetHeight(self.bounds));
            
            [button setTitle:self.dataArray[index] forState:UIControlStateNormal];
            [button setTitleColor:self.titleNomalColor forState:UIControlStateNormal];
            [button setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(segmentViewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            if (index == 0) {
                button.selected = YES;
            }else {
                button.selected = NO;
            }
            button;
        });
        [self.buttonArray addObject:button];
        [self.scrollView addSubview:button];
    }
}


#pragma mark - textLength
- (CGFloat)textLength:(NSString *)string andFont:(UIFont *)font {
    
    CGSize customSize ;
    customSize.width = kScreenWidth;
    customSize.height = 0;
    
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGFloat length =
    [string boundingRectWithSize:customSize
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:attribute
                         context:nil].size.width;
    return length;
}

#pragma mark - buttonClick
- (void)segmentViewButtonClick:(UIButton *)sender {
    if (sender != self.selectedButton) {
        NSInteger selectedIndex = sender.tag - kFixedRadix;
        [self setSelectedIndex:selectedIndex animated:YES];
        if (self.block) {
            self.block(selectedIndex);
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated {
    for (UIButton *button in self.buttonArray) {
        [button setSelected:NO];
    }
    UIButton *selectedButton = self.buttonArray[selectedIndex];
    selectedButton.selected = YES;
    _selectedButton = selectedButton;
    _selectedIndex = selectedIndex;
    
    CGFloat length = [self textLength:selectedButton.titleLabel.text andFont:self.titleFont];
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.lineLabel.xhq_width = length;
            self.lineLabel.xhq_centerX = selectedButton.xhq_centerX;
        }];
    }else {
        self.lineLabel.xhq_width = length;
        self.lineLabel.xhq_centerX = selectedButton.xhq_centerX;
    }
    return;
    NSLog(@"%f````%f",selectedButton.xhq_width,selectedButton.xhq_x);
    if (self.buttonArray.count > kMostScreenDisplay && selectedButton.xhq_right > kScreenWidth) {
        self.scrollView.contentOffset = CGPointMake(selectedButton.xhq_x - selectedButton.xhq_width, 0);
    }
}

#pragma mark - setter

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        [self setSelectedIndex:selectedIndex animated:NO];
    }
}

- (void)setTitleNomalColor:(UIColor *)titleNomalColor {
    if (_titleNomalColor != titleNomalColor) {
        _titleNomalColor = titleNomalColor;
        for (UIButton *button in self.buttonArray) {
            [button setTitleColor:titleNomalColor forState:UIControlStateNormal];
        }
    }
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    if (_titleSelectedColor != titleSelectedColor) {
        _titleSelectedColor = titleSelectedColor;
        for (UIButton *button in self.buttonArray) {
            [button setTitleColor:titleSelectedColor forState:UIControlStateSelected];
        }
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    if (_titleFont != titleFont) {
        _titleFont = titleFont;
        for (UIButton *button in self.buttonArray) {
            button.titleLabel.font = titleFont;
        }
    }
}

- (void)setLineColor:(UIColor *)lineColor {
    if (_lineColor != lineColor) {
        _lineColor = lineColor;
        _lineLabel.backgroundColor = lineColor;
    }
}

#pragma mark - getter

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_image_view_bg]];
        _bgImageView.frame = self.bounds;
    }
    return _bgImageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.xhq_width, self.xhq_height)];
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        if (self.buttonArray.count == 0) {
            return nil;
        }
        UIButton *button = self.buttonArray[0];
        CGFloat length = [self textLength:button.titleLabel.text andFont:self.titleFont];
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.xhq_height = 1.5;
        _lineLabel.xhq_y = CGRectGetHeight(self.bounds) - 1.5;
        _lineLabel.xhq_width = length;
        _lineLabel.xhq_centerX = button.xhq_centerX;
        _lineLabel.backgroundColor = _lineColor;
    }
    return _lineLabel;
}

- (NSMutableArray *)buttonArray {
    if (!_buttonArray) {
        _buttonArray = [[NSMutableArray alloc]init];
    }
    return _buttonArray;
}

@end
