//
//  DYGongGaoDetailVC.m
//  AntRepay
//
//  Created by 崔祥莉 on 2017/11/21.
//  Copyright © 2017年 diyunkeji. All rights reserved.
//

#import "DYGongGaoDetailVC.h"
#import "DYGongGaoDetailView.h"

@interface DYGongGaoDetailVC ()<UIWebViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DYGongGaoDetailView *detailView;
@property (nonatomic, assign) CGFloat height;
@end

@implementation DYGongGaoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)dy_initData {
    [super dy_initData];
    self.navigationItem.title = self.isCareful ? @"注意事项详情" : @"公告详情";
    if ([self.idStr isEqualToString:@"51"]) { //代理加盟
        self.navigationItem.title = @"代理加盟";
    }else if ([self.idStr isEqualToString:@"50"]) {
        self.navigationItem.title = @"关于我们";
    }
}

-(void)dy_initUI{
    [super dy_initUI];
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [self.view addSubview:_scrollView];
    _detailView = [[DYGongGaoDetailView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTopHeight)];
    [_scrollView addSubview:_detailView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    _detailView.webView.delegate = self;
}

-(void)dy_request{
    XHQHUDBGSHOW(self.view);
    NSDictionary *params = @{@"id":self.idStr};
    [DYAppReq GET:_url_gongGao_detail param:params callBack:^(id responseObject, NSError *error) {
        if (!error) {
            if (DYAPPREQSUCCESS) {
                NSDictionary *dic = responseObject[@"info"];
                 [_detailView setTitle:dic[@"title"] time:dic[@"time"]];
                [_detailView.webView loadHTMLString:dic[@"content"] baseURL:nil];
            }else{
                XHQHUDHIDE(self.view);
                XHQHUDMESSAGE;
            }
        }else{
            XHQHUDFAIL(self.view);
        }
    }];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    XHQHUDHIDE(self.view);
    [webView stringByEvaluatingJavaScriptFromString:
     
     @"var script = document.createElement('script');"
     
     "script.type = 'text/javascript';"
     
     "script.text = \"function ResizeImages() { "
     
     "var myimg,oldwidth;"
     
     "var maxwidth=document.body.clientWidth;" //缩放系数</span>
     
     "for(i=0;i <document.images.length;i++){"
     
     "myimg = document.images[i];"
     
     "if(myimg.width > maxwidth){"
     
     "oldwidth = myimg.width;"
     
     "myimg.width = maxwidth-20;"
     
     "myimg.height = myimg.height;"
     
     "}"
     
     "}"
     
     "}\";"
     
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    XHQHUDHIDE(self.view);
}


@end
