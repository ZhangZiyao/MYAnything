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
    
    UIButton *visitPhoto = [[UIButton alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT+5, MAINSCREEN_WIDTH, 30)];
    [visitPhoto setTitle:@"访问相册" forState:UIControlStateNormal];
    [visitPhoto setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:visitPhoto];
    [visitPhoto addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    visitPhoto.tag = 10;
    
    UIButton *map = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(visitPhoto)+5, MAINSCREEN_WIDTH, 30)];
    [map setTitle:@"地图/定位相关" forState:UIControlStateNormal];
    [map setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:map];
    [map addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    map.tag = 11;
    
    UIButton *zbar = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(map)+5, MAINSCREEN_WIDTH, 30)];
    [zbar setTitle:@"二维码" forState:UIControlStateNormal];
    [zbar setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:zbar];
    [zbar addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    zbar.tag = 12;
    
    UIButton *player = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(zbar)+5, MAINSCREEN_WIDTH, 30)];
    [player setTitle:@"播放器" forState:UIControlStateNormal];
    [player setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:player];
    [player addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    player.tag = 13;
    
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
