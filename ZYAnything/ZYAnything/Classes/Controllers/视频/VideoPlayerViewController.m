//
//  VideoPlayerViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "VideoPlayerViewController.h"
#import "UIDefines.h"

@interface VideoPlayerViewController ()

@end

@implementation VideoPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBack:@selector(backAction)];
    [self setNavTitle:@"视频播放器"];
    self.view.backgroundColor = BGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
