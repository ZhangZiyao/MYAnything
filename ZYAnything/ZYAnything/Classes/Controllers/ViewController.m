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
#import "QRCodeViewController.h"
#import "MusicPlayerViewController.h"
#import "VideoPlayerViewController.h"
#import "Base64.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Anything";
    
    self.view.backgroundColor = BGColor;
    [self makeUI];
    
    NSString *str = [@"lalala" base64EncodedString];
    
    NSData *dataa = [NSData dataWithBase64EncodedString:str];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"111",@"222",@"222",@"sdsd",@"wwer",@"werewr",dataa,@"qqqqq", nil];
    NSLog(@"%@%@",str,dic);
    
    
    
    
    
    
    
    
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
    
    UIButton *qrCode = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(map)+5, MAINSCREEN_WIDTH, 30)];
    [qrCode setTitle:@"二维码" forState:UIControlStateNormal];
    [qrCode setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:qrCode];
    [qrCode addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    qrCode.tag = 12;
    
    UIButton *musicPlayer = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(qrCode)+5, MAINSCREEN_WIDTH, 30)];
    [musicPlayer setTitle:@"音乐播放器" forState:UIControlStateNormal];
    [musicPlayer setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:musicPlayer];
    [musicPlayer addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    musicPlayer.tag = 13;
    
    UIButton *videoPlayer = [[UIButton alloc] initWithFrame:CGRectMake(0,MaxY(musicPlayer)+5, MAINSCREEN_WIDTH, 30)];
    [videoPlayer setTitle:@"视频播放器" forState:UIControlStateNormal];
    [videoPlayer setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:videoPlayer];
    [videoPlayer addTarget:self action:@selector(btnClickAction:) forControlEvents:UIControlEventTouchUpInside];
    videoPlayer.tag = 14;
    
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
        case 12:
        {
            vc = [[QRCodeViewController alloc] init];
        }
            break;
        case 13:
        {
            vc = [[MusicPlayerViewController alloc] init];
        }
            break;
        case 14:
        {
            vc = [[VideoPlayerViewController alloc] init];
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
