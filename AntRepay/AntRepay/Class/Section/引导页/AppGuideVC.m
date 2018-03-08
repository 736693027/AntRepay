//
//  AppGuideVC.m
//  OfficialCar
//
//  Created by 帝云科技 on 2017/7/31.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "AppGuideVC.h"
#import "DYTabBarController.h"
#import "XHQ.h"

@interface AppGuideVC ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *guideScrollView;
@property (nonatomic, strong) UIButton *operationButton;

@end

static NSString *const _image_guide_1 = @"yind";
static NSString *const _image_guide_2 = @"yind1";
static NSString *const _image_guide_3 = @"yind2";
static NSString *const _image_guide_4 = @"yind3";

@implementation AppGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.guideScrollView];
    [self.view addSubview:self.operationButton];
    [self guideSubImageViews];
}

- (UIScrollView *)guideScrollView {
    if (!_guideScrollView) {
        _guideScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _guideScrollView.bounces = NO;
        _guideScrollView.pagingEnabled = YES;
        _guideScrollView.delegate = self;
        _guideScrollView.showsVerticalScrollIndicator = NO;
        _guideScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _guideScrollView;
}

- (UIButton *)operationButton {
    if (!_operationButton) {
        CGSize buttonSize = CGSizeMake(150, 50);
        _operationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _operationButton.frame = CGRectMake((kScreenWidth - buttonSize.width)/2, (kScreenHeight - buttonSize.height - BILIHEIGHT(70)), buttonSize.width, buttonSize.height);
        ViewBorderRadius(_operationButton, 5.f, 3, [UIColor whiteColor]);
        _operationButton.backgroundColor = [UIColor clearColor];
        [_operationButton setTitle:@"立即开始" forState:UIControlStateNormal];
        _operationButton.xhqFont = XHQ_FONTBOLD(18);
        _operationButton.hidden = YES;
        [_operationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_operationButton addTarget:self action:@selector(operationClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _operationButton;
}

- (void)guideSubImageViews {
    NSArray *imagesArray = @[_image_guide_1, _image_guide_2, _image_guide_3, _image_guide_4];
    NSInteger arrayCount = imagesArray.count;
    _guideScrollView.contentSize = CGSizeMake(kScreenWidth * arrayCount, kScreenWidth);
    
    for (NSInteger index = 0; index < arrayCount; index ++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imagesArray[index]]];
        imageView.frame = CGRectMake(index * kScreenWidth, 0, kScreenWidth, kScreenHeight);
        [_guideScrollView addSubview:imageView];
    }
}


- (void)operationClick:(UIButton *)sender {
    [[DYAppContext sharedDYAppContext] checkLogin];
    self.view.window.rootViewController = [[DYTabBarController alloc]init];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger currentIndex = (NSInteger)scrollView.contentOffset.x / scrollView.xhq_width;
    if (currentIndex == 3) {
        _operationButton.hidden = NO;
    }else {
        _operationButton.hidden = YES;
    }
}


@end
