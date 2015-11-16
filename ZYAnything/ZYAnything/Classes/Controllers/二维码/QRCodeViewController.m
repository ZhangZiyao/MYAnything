//
//  QRCodeViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

/*
 做iOS的二维码扫描，有两个第三方库可以选择，ZBar和ZXing。
 iOS7.0后可以用AVFoundation框架提供的原生二维码扫描
 */
#import "QRCodeViewController.h"
#import "UIDefines.h"

@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.view.backgroundColor = BGColor;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
