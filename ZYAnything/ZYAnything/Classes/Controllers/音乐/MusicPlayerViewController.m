//
//  MusicPlayerViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "MusicPlayerViewController.h"
#import "UIDefines.h"

@interface MusicPlayerViewController ()

@end

@implementation MusicPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBack:@selector(backAction)];
    [self setNavTitle:@"音乐播放器"];
    self.view.backgroundColor = BGColor;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self.view addSubview:btn];
    
}

- (void)backPreview{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
