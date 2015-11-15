//
//  ViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/13.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "ViewController.h"
#import "UIDefines.h"
#import "VisitPhotoViewController.h"
#import "MapViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Anything";
    
    self.view.backgroundColor = BGColor;
    [self makeUI];
}

- (void)makeUI{
    
    UIButton *visitPhoto = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH/2.f-50, 100, 100, 30)];
    [visitPhoto setTitle:@"访问相册" forState:UIControlStateNormal];
    [visitPhoto setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:visitPhoto];
    [visitPhoto addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    visitPhoto.tag = 10;
    
    UIButton *map = [[UIButton alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH/2.f-100, visitPhoto.frame.origin.y+100+10, 200, 30)];
    [map setTitle:@"地图/定位相关" forState:UIControlStateNormal];
    [map setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:map];
    [map addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    map.tag = 11;
    
}

- (void)btnClickAction:(UIButton *)sender{
    UIViewController *vc = nil;
    switch (sender.tag) {
        case 10:
        {
            vc = [[VisitPhotoViewController alloc] init];
        }
            break;
        case 11:
        {
            vc = [[MapViewController alloc] init];
        }
            break;
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
