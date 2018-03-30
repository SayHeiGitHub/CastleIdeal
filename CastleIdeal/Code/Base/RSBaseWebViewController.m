//
//  RSBaseWebViewController.m
//  RepublicShare
//
//  Created by 姜鸥人 on 2017/10/16.
//  Copyright © 2017年 姜鸥人. All rights reserved.
//

#import "RSBaseWebViewController.h"

#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

@interface RSBaseWebViewController ()<UIWebViewDelegate, NJKWebViewProgressDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NJKWebViewProgress     *progressProxy;
@property (nonatomic, strong) NJKWebViewProgressView *progressView;

@end

@implementation RSBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addTiTle:self.titleString];
    [self addLeftBackButton];
    
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 2, kScreenWidth, kScreenHeight - 2)];
    _webView.backgroundColor = kBaseBgColor;
    _webView.scalesPageToFit = YES;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _webView.contentMode = UIViewContentModeRedraw;
    _webView.opaque = YES;
    _webView.mediaPlaybackRequiresUserAction=NO; //webView能播放声音
    [self.view addSubview:_webView];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate     = self;
    CGRect barFrame = CGRectMake(0,kNavBarHeight, kScreenWidth, 2.0f);
    _progressView   = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    [self.view addSubview:_progressView];
    _progressView.progressBarView.backgroundColor = kYellow;
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:_progressView];
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlString]];
    [_webView loadRequest:req];
}

#pragma mark - NJKWebViewProgressDelegate

-(void)webViewProgress:(NJKWebViewProgress*)webViewProgress updateProgress:(float)progress {
    [self.progressView setProgress:progress animated:YES];
}




@end
