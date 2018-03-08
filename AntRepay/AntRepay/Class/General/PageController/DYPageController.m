//
//  DYPageController.m
//  Huixin
//
//  Created by 帝云科技 on 2017/7/25.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYPageController.h"

#define kSegmentHeight BILIHEIGHT(45)

@interface DYPageController ()<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign, readwrite) NSInteger currentIndex;

@end

@implementation DYPageController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)dy_initData {
    [super dy_initData];
    self.currentIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)dy_initUI {
    [super dy_initUI];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.collectionView];
}

- (void)reloadUI {
    [self.titleView removeFromSuperview];
    [self.collectionView removeFromSuperview];
    self.titleView = nil;
    self.collectionView = nil;
    [self dy_initUI];
}

#pragma mark - setter

- (void)setCanScroll:(BOOL)canScroll {
    _canScroll = canScroll;
    _collectionView.scrollEnabled = canScroll;
}

- (void)setCanClick:(BOOL)canClick {
    _canClick = canClick;
    _titleView.userInteractionEnabled = canClick;
}

#pragma mark - getter

- (DYPageTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[DYPageTitleView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kSegmentHeight)
                                            withTitleArray:self.titleArray];
        @weakify(self);
        _titleView.block = ^(NSInteger selectedIndex) {
            @strongify(self);
            [self titleViewSelectedIndex:selectedIndex];
        };
    }
    return _titleView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight - kSegmentHeight - kNavigationStatusHeight);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, kSegmentHeight, kScreenWidth, kScreenHeight - kNavigationStatusHeight - kSegmentHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.bounces = NO;
        _collectionView.scrollEnabled = YES;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    }
    return _collectionView;
}


#pragma mark - titleViewSelectedIndex
- (void)titleViewSelectedIndex:(NSInteger)index {
    CGPoint offset = CGPointMake(index * kScreenWidth, 0);
    [_collectionView setContentOffset:offset animated:NO];
    self.currentIndex = index;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.xhq_width;
    [_titleView setSelectedIndex:index animated:YES];
    self.currentIndex = index;
}

#pragma mark - UICollectionViewD

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childViewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UIViewController *vc = self.childViewControllers[indexPath.row];
    [cell.contentView addSubview:vc.view];
    return cell;
}

#pragma mark - getter

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [[NSArray alloc]init];
    }
    return _titleArray;
}

@end
