//
//  DYHomeWebVC.m
//  AntRepay
//
//  Created by 帝云科技 on 2017/12/27.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYHomeWebVC.h"
#import <WebKit/WebKit.h>

@interface DYHomeWebVC ()<
WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation DYHomeWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)dy_initData {
    [super dy_initData];
    self.fd_interactivePopDisabled = YES;
}

- (void)dy_initUI {
    [super dy_initUI];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"return"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"guanb_zhc"]
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(close)];
    [self.view addSubview:self.webView];
}

- (void)dy_request {
    NSString *urlString;
    switch (self.type) {
        case webTypeApplyLoan:
            urlString = _url_apply_loan;
            break;
        case webTypeApplyCard:
            urlString = _url_apply_card;
            break;
        case webTypeCardPorgress:
            urlString = _url_card_progress;
            break;
        default:
            break;
    }
    NSURL *url = [NSURL URLWithString:urlString];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)back {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self close];
    }
}

- (void)close {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    XHQHUDSHOW(self.view);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    XHQHUDHIDE(self.view);
    NSString *title = webView.title;
    if ([NSString xhq_notEmpty:title]) {
        self.navigationItem.title = title;
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    XHQHUDHIDE(self.view);
}

#pragma mark - getter
- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationStatusHeight)];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end
