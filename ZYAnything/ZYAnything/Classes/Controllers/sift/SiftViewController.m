//
//  SiftViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/7.
//  Copyright © 2016年 soez. All rights reserved.
//

#import "SiftViewController.h"
#import "UIDefines.h"
#import "MenuViewController.h"
#import "ControlsViewController.h"

@interface SiftViewController ()
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *upView;

@end

@implementation SiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGColor;
    
//    [self setNavBack:@selector(backAction)];
//    [self setNavTitle:@"筛选"];
    
    
    UIButton *sift = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 50, 30)];
    [sift setTitle:@"筛选" forState:UIControlStateNormal];
    [sift setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:sift];
    sift.tag = 10086;
    [sift addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sift1 = [[UIButton alloc] initWithFrame:CGRectMake(30, 200, 50, 30)];
    [sift1 setTitle:@"筛选1" forState:UIControlStateNormal];
    [sift1 setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:sift1];
    sift1.tag = 10010;
    [sift1 addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 10086) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT)];
        window.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        window.windowLevel = UIWindowLevelNormal;
        window.hidden = NO;
        [window makeKeyAndVisible];
        MenuViewController *up = [[MenuViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:up];
        up.view.frame = window.bounds;
        window.rootViewController = nav;
        self.window = window;
        
        
        
        UIView *view = [[UIView alloc] initWithFrame:self.window.bounds];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        //    [self.view addSubview:view];
        [self.view.window addSubview:view];
        [UIView animateWithDuration:0.2 animations:^{
            window.frame = CGRectMake(60, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT);
        }];
        
        self.upView = view;
        
        __weak typeof(self) weak = self;
        [up setCancleBarItemHandle:^{
            [UIView animateWithDuration:1 animations:^{
                weak.window.frame = CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT);
                [weak.upView removeFromSuperview];
            }];
            
            
            [weak.window resignKeyWindow];
            weak.window  = nil;
            weak.upView = nil;
        }];
    }else{
//        ControlsViewController *controlVc = [[ControlsViewController alloc] init];
//        [self.navigationController pushViewController:controlVc animated:YES];
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT)];
        window.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:1];
        window.windowLevel = UIWindowLevelNormal;
        window.hidden = NO;
        [window makeKeyAndVisible];
        ControlsViewController *up = [[ControlsViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:up];
        up.view.frame = window.bounds;
        window.rootViewController = nav;
        self.window = window;
        
        
        
        UIView *view = [[UIView alloc] initWithFrame:self.window.bounds];
        view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [view addGestureRecognizer:tap];
        //    [self.view addSubview:view];
        [self.view.window addSubview:view];
        [UIView animateWithDuration:0.2 animations:^{
            window.frame = CGRectMake(60, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT);
        }];
        
        self.upView = view;
        
        __weak typeof(self) weak = self;
        [up setCancleBarItemHandle:^{
            [UIView animateWithDuration:1 animations:^{
                weak.window.frame = CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT);
                [weak.upView removeFromSuperview];
            }];
            
            
            [weak.window resignKeyWindow];
            weak.window  = nil;
            weak.upView = nil;
        }];

    }
}

- (void)tapAction{
    [UIView animateWithDuration:1.0 animations:^{
        self.window.frame = CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-60, MAINSCREEN_HEIGHT);
    }];
    [self.upView removeFromSuperview];
    
    [self.window resignKeyWindow];
    self.window  = nil;
    self.upView = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
