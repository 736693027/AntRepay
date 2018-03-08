//
//  XHQBigImage.m
//  Excellence
//
//  Created by 帝云科技 on 2017/7/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "XHQBigImage.h"

static CGRect oldFrame;
static CGRect newFrame;
static CGRect largerFrame;
static UIView *backgroundView;

@implementation XHQBigImage

+ (void)xhq_bigShow:(UIImageView *)imageView {
    UIView *keyWindow = [self keyWindow];
    backgroundView = [self backgroundView];
    UIImageView *showImageView = [self showImageView];
    showImageView.image = imageView.image;
    
    oldFrame = [imageView convertRect:imageView.bounds toView:keyWindow];
    newFrame = backgroundView.bounds;
    largerFrame = CGRectMake(-kScreenWidth, -kScreenWidth, kScreenWidth * 3, kScreenHeight * 3);
    
    [backgroundView addSubview:showImageView];
    [[self keyWindow] addSubview:backgroundView];
    
    showImageView.frame = oldFrame;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [UIView animateWithDuration:0.3 animations:^{
        showImageView.frame = newFrame;
    }];
    
}


+ (UIView *)keyWindow {
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIView *)backgroundView {
    return ({
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        view.backgroundColor = [UIColor blackColor];
        view;
    });
}

+ (UIImageView *)showImageView {
    return ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:[self tapGesture]];
        [imageView addGestureRecognizer:[self panGesture]];
        [imageView addGestureRecognizer:[self pinchGesture]];
        imageView;
    });
}

+ (UITapGestureRecognizer *)tapGesture {
    return [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMethod:)];
}

+ (UIPinchGestureRecognizer *)pinchGesture {
    return [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchMethod:)];
}

+ (UIPanGestureRecognizer *)panGesture {
    return [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMethod:)];
}


+ (void)tapMethod:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    UIImageView *imageView = (UIImageView *)tap.view;
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldFrame;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
        [backgroundView removeFromSuperview];
    }];
}

+ (void)pinchMethod:(UIPinchGestureRecognizer *)pinch {
    UIImageView *imageView = (UIImageView *)pinch.view;
    if (pinch.state == UIGestureRecognizerStateBegan ||
        pinch.state == UIGestureRecognizerStateChanged) {
        imageView.transform = CGAffineTransformScale(imageView.transform, pinch.scale, pinch.scale);
        pinch.scale = 1;
    }
    if (pinch.state == UIGestureRecognizerStateEnded) {
        if (CGRectGetWidth(imageView.frame) < CGRectGetWidth(newFrame)) {
            [UIView animateWithDuration:0.1 animations:^{
                imageView.frame = newFrame;
            }];
        }
        if (CGRectGetWidth(imageView.frame) > CGRectGetWidth(largerFrame)) {
            CGPoint cener = imageView.center;
            [UIView animateWithDuration:0.1 animations:^{
                imageView.frame = largerFrame;
                imageView.center = cener;
            }];
        }
    }
}

+ (void)panMethod:(UIPanGestureRecognizer *)pan {
    UIImageView *imageView = (UIImageView *)pan.view;
    if (pan.state == UIGestureRecognizerStateBegan ||
        pan.state == UIGestureRecognizerStateChanged) {
        CGPoint panPoint = [pan translationInView:imageView.superview];
        UIImage *image = imageView.image;
        CGFloat contentScale = CGRectGetWidth(imageView.frame) / CGRectGetWidth(newFrame);

        if (image.size.width * contentScale <= kScreenWidth * 2 &&
            image.size.height * contentScale <= kScreenHeight * 2 &&
            CGPointEqualToPoint(imageView.center, backgroundView.center)) {
            panPoint.x = panPoint.y = 0;
        }else if (image.size.width * contentScale < kScreenWidth * 2 &&
                  image.size.height * contentScale > kScreenHeight * 2 &&
                  CGPointEqualToPoint(imageView.center, backgroundView.center)) {
            panPoint.x = 0;
        }else if (image.size.width * contentScale > kScreenWidth * 2 &&
                  image.size.height * contentScale < kScreenHeight * 2 &&
                  CGPointEqualToPoint(imageView.center, backgroundView.center)) {
            panPoint.y = 0;
        }
        [imageView setCenter:CGPointMake(imageView.center.x + panPoint.x, imageView.center.y + panPoint.y)];
        [pan setTranslation:CGPointZero inView:imageView.superview];
    }
}

@end
