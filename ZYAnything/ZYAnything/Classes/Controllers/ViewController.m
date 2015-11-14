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
    
    
    
}

- (void)btnClickAction:(UIButton *)sender{
    
    switch (sender.tag) {
        case 10:
        {
            VisitPhotoViewController *visitPhoto = [[VisitPhotoViewController alloc] init];
            [self.navigationController pushViewController:visitPhoto animated:YES];
        }
            break;
        case 11:
        {
            
        }
            break;
            
        default:
            break;
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
