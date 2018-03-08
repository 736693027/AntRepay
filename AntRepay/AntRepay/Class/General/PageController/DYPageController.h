//
//  DYPageController.h
//  Huixin
//
//  Created by 帝云科技 on 2017/7/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYViewController.h"
#import "DYPageTitleView.h"

@interface DYPageController : DYViewController

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) DYPageTitleView *titleView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, assign) BOOL canClick;

@property (nonatomic, assign, readonly) NSInteger currentIndex;

- (void)reloadUI;

@end
