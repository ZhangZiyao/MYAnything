//
//  MyBlogViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/12/15.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "MyBlogViewController.h"
#import "UIDefines.h"

@interface MyBlogViewController ()
{
    UIWebView *webView;
}

@end

@implementation MyBlogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = BGColor;
//    [self setNavTitle:@"MyBlog"];
    [self setNavBack:@selector(backAction)];
    
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ziyao.co"]];
    [webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
