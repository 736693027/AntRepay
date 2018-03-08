//
//  DYProtocolVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYProtocolVC.h"

@interface DYProtocolVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DYProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)dy_initUI{
    [super dy_initUI];
    self.title = @"注册协议";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[kGetImage(@"return") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(closeAction:)];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
}

- (void)dy_request{
    [MBProgressHUD showMessage:nil toView:self.view];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer.timeoutInterval = 15.0f;
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    XHQ_Log(@"%@",NSStringFormat(@"%@%@",BaseURL,RegisterXieYi));
    [session GET:NSStringFormat(@"%@%@",_url_base,RegisterXieYi) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([responseObject[@"status"] intValue] == 9999) {
            [_webView loadHTMLString:responseObject[@"message"] baseURL:nil];
        }else{
            [MBProgressHUD showMessage:responseObject[@"message"] toView:self.view];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    XHQHUDSHOW(self.view);
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    XHQHUDHIDE(self.view);
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    XHQHUDHIDE(self.view);
    XHQ_Log(@"请求失败");
}

- (void)closeAction:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
