//
//  XHQImagePicker.m
//  Julong
//
//  Created by 帝云科技 on 2017/7/20.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHQImagePicker.h"

@interface XHQImagePicker ()<
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>

@property (nonatomic, copy) XHQFinishedImageHandler handler;
@property (nonatomic, weak) UIViewController *viewController;

@end

static XHQImagePicker *_xhqImagePicker = nil;

@implementation XHQImagePicker

+ (void)xhq_imagePicker:(UIViewController *)viewController finish:(XHQFinishedImageHandler)handler {
    if (!_xhqImagePicker) {
        _xhqImagePicker = [[XHQImagePicker alloc]init];
    }
    [_xhqImagePicker xhq_imagePicker:viewController finish:handler];
}

- (void)xhq_imagePicker:(UIViewController *)viewController finish:(XHQFinishedImageHandler)handler {
    _viewController = viewController;
    _handler = handler;
    
    [self setActionSheetController];
}

- (void)setActionSheetController {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:nil
                                                                   message:@"请选择"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionPhoto = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *actionCamera = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self imagePickerControllerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        }else {
            NSLog(@"%@",@"模拟器无法打开拍照功能，请用真机打开");
        }
    }];
    UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        _xhqImagePicker = nil;
    }];
    [sheet addAction:actionCamera];
    [sheet addAction:actionPhoto];
    [sheet addAction:actionCancel];
    [_viewController presentViewController:sheet animated:YES completion:nil];
}

- (void)imagePickerControllerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    picker.allowsEditing = YES;
    [_viewController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (image) {
        if (_handler) {
            _handler(image);
        }
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
    _xhqImagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"cancel");
    [picker dismissViewControllerAnimated:YES completion:nil];
    _xhqImagePicker = nil;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController isKindOfClass:[UIImagePickerController class]]) {
        viewController.navigationController.navigationBar.barTintColor = [UIColor xhq_base];
        viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    }
}

@end
