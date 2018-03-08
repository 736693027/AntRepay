//
//  DYNavgationView.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/26.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYNavgationView.h"


#define kScrollHeight BILIHEIGHT(170)

@interface DYNavgationView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *lineLabel;

@end

@implementation DYNavgationView

- (void)dealloc {
    [self removeObserver:self.superScrollView forKeyPath:@"contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationStatusHeight)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavigationStatusHeight)];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.alpha = 1;
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.centerX.equalTo(0);
        make.top.equalTo(kStatusBarHeight);
        make.width.equalTo(BILIWIDTH(200));
    }];
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(0);
        make.height.equalTo(0.5);
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    self.superButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:1.f];
    [self.superScrollView addObserver:self
                           forKeyPath:@"contentOffset"
                              options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (![object isKindOfClass:[UIScrollView class]]) return;
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint currentOffSet = [change[@"new"] CGPointValue];
//        CGFloat height = (CGFloat)roundf(kScrollHeight);
        CGFloat offsetY = currentOffSet.y;
        float alpha = offsetY / (kScrollHeight - kNavigationStatusHeight);
        alpha = alpha >= 1 ? 1.f : alpha;
        alpha = alpha <= 0 ? 0.f : alpha;
        self.alpha = alpha;
        self.superButton.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:alpha];
    }
}

#pragma mark - getter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel xhq_layoutColor:[UIColor xhq_aTitle]
                                          font:[UIFont xhq_font18]
                                          text:@"我的"];
        _titleLabel.textAlignment = 1;
    }
    return _titleLabel;
}

- (UILabel *)lineLabel {
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.7];
    }
    return _lineLabel;
}

@end
