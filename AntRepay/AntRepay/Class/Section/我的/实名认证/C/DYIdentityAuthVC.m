//
//  DYIdentityAuthVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/24.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYIdentityAuthVC.h"
#import "DYIdentityAuthView.h"
#import "BDImagePicker.h"
#import "DYShiMingVC.h"
#import "UIViewController+Ext.h"

@interface DYIdentityAuthVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DYIdentityAuthView *authView;
@property (nonatomic, strong) NSDictionary *imgDic;
@end

@implementation DYIdentityAuthVC

-(NSDictionary *)imgDic{
    if (!_imgDic) {
        _imgDic = [NSDictionary dictionary];
    }
    return _imgDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.view.backgroundColor = [UIColor xhq_section];
    self.title = @"身份认证";
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    _authView = [[DYIdentityAuthView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, BILIHEIGHT(700))];
    [_scrollView addSubview:_authView];
    _scrollView.contentSize = CGSizeMake(0, BILIHEIGHT(700));
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self aboutAuthView];
}

- (void)aboutAuthView{
    __weak typeof(self) weakSelf = self;
    _authView.firstBlock = ^(UIImage * _Nullable image) {
        [weakSelf choiceIconWithType:@"idcard_positive"];
    };
    _authView.secondBlock = ^(UIImage * _Nullable image) {
        [weakSelf choiceIconWithType:@"idcard_opposite"];
    };
    _authView.thirdBlock = ^(UIImage * _Nullable image) {
        [weakSelf choiceIconWithType:@"idcard_hold"];
    };
    _authView.forthBlock = ^(UIImage * _Nullable image) {
        [weakSelf choiceIconWithType:@"bank_positive"];
    };
    _authView.fifthBlock = ^(UIImage * _Nullable image) {
        [weakSelf choiceIconWithType:@"bank_opposite"];
    };
    _authView.sixBlock = ^(UIImage * _Nonnull image) {
        [weakSelf choiceIconWithType:@"bank_hold"];
    };
    @weakify(self);
    // 下一步
    _authView.nextBlock = ^(UIImage *firstImg, UIImage *secondImg, UIImage *thirdImg, UIImage *forthImg, UIImage *fifthImg, UIImage *sixImg) {
        @strongify(self);
        if ([weakSelf.imgDic[@"idcard_positive"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传身份证证件 ( 正面 )");
        }else if ([weakSelf.imgDic[@"idcard_opposite"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传身份证证件 ( 反面 )");
        }else if ([weakSelf.imgDic[@"idcard_hold"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传手持身份证照片");
        }else if ([weakSelf.imgDic[@"bank_positive"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传信用卡照片 ( 正面 )");
        }else if ([weakSelf.imgDic[@"bank_opposite"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传信用卡照片 ( 反面 )");
        }else if ([weakSelf.imgDic[@"bank_hold"] isEqualToString:@""]) {
            XHQHUDTEXT(@"请上传手持信用卡卡照片");
        }else{
            if ([DYAppCertification sharedDYAppCertification].isIdentity) {
                JWALERT_ONE_ACTION_SHOW(@"提示",
                                        @"身份认证成功",
                                        @"确定",
                                        [self xhq_popToViewControllerWithIndex:2]);
            }
            else {
                DYShiMingVC *vc = [[DYShiMingVC alloc] init];
                WEAKPUSHVC(vc);
            }
        }
    };
}

// 上传图片类型
- (void)choiceIconWithType:(NSString *)type{
    // 上传图片类型
    [BDImagePicker showImagePickerFromViewController:self allowsEditing:NO finishAction:^(UIImage *image) {
        if (image) {
            [self requestIconDataWithImage:image type:type];
        }
    }];
}

// 图片获取
-(void)dy_request{
    [self checkCertificationStatus];
    XHQHUDSHOW(self.view);
    NSDictionary *params = @{DY_APP_KEY_VALUE_REQ};
    [DYAppReq POST:_url_auth_get_image param:params callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                [_authView setValueWithDictionary:responseObject[@"image"]];
                self.imgDic = responseObject[@"image"];
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)checkCertificationStatus {
    [[DYAppCertification sharedDYAppCertification] certificationCompletion:^(BOOL isIdentity, BOOL isImages) {
        if (isIdentity) {
            [_authView.nextBtn setTitle:@"完成" forState:UIControlStateNormal];
        }
        else {
            [_authView.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        }
    }];
}

// 上传图片
- (void)requestIconDataWithImage:(UIImage *)image type:(NSString *)type{
    NSDictionary *param = @{DY_APP_KEY_VALUE_REQ,
                            @"type":type
                            };
    XHQHUDSHOW(self.view);
    [DYAppReq dy_upload:_url_auth_image name:@"image" image:image param:param callBack:^(id responseObject, NSError *error) {
        XHQHUDHIDE(self.view);
        if (!error) {
            if (DYAPPREQSUCCESS) {
                XHQHUDTEXT(@"上传成功");
                [self dy_request];
            }else {
                XHQALERTMESSAGE
            }
        }else {
            XHQHUDFAIL(self.view);
        }
    }];
}



@end
