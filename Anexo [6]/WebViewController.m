//
//  WebViewController.m
//  TFM - Protección de Aplicaciones Móviles en iOS
//
//  Created by Felix Garcia Lainez on 18/3/18.
//  Copyright (c) 2018. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WebViewController() <WKNavigationDelegate, WKUIDelegate>

@property(nonatomic, strong) WKWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    WKPreferences* preferences = [[WKPreferences alloc] init];
    
    // Disable JavasSript execution
    [preferences setJavaScriptEnabled:NO];
    [preferences setJavaScriptCanOpenWindowsAutomatically:NO];
    
    WKWebViewConfiguration* configuration = [[WKWebViewConfiguration alloc] init];
    [configuration setPreferences:preferences];

    _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration] ;
    [self.view addSubview:_webView];
}

@end
