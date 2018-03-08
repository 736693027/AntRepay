//
//  XHQHud.m
//  Excellence
//
//  Created by 帝云科技 on 2017/7/4.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "XHQHud.h"
#import "MBProgressHUD.h"


@implementation XHQHud

+ (void)text:(NSString *)text {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [self text:text inView:keyWindow];
}

+ (void)text:(NSString *)text inView:(UIView *)view {
    NSCharacterSet * whiteSpaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    text = [text stringByTrimmingCharactersInSet:whiteSpaceSet];
    
    if (!view || !text) {
        return;
    }
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode =  MBProgressHUDModeText;
    HUD.detailsLabel.text = text;
    HUD.bezelView.backgroundColor = [UIColor blackColor];
    HUD.detailsLabel.font = HUD.label.font;
    HUD.detailsLabel.textColor = [UIColor whiteColor];
    HUD.animationType = MBProgressHUDAnimationZoomOut;
    [HUD hideAnimated:YES afterDelay:1.5];
}

+ (void)showView:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.offset = CGPointMake(0, -64);
}

+ (void)showBgView:(UIView *)view {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.offset = CGPointMake(0, -64);
    HUD.backgroundColor = [UIColor xhq_section];
}

+ (void)hideView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
    
}

@end
