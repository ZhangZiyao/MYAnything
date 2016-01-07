//
//  SiftViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/7.
//  Copyright © 2016年 soez. All rights reserved.
//

#import "SiftViewController.h"
#import "UIDefines.h"
#import "MGMineMenuVc.h"

@interface SiftViewController ()
@property (nonatomic,strong) UIWindow *window;
@property (nonatomic,strong) UIView *upView;

@end

@implementation SiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BGColor;
    
    
    UIButton *sift = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 50, 30)];
    [sift setTitle:@"筛选" forState:UIControlStateNormal];
    [sift setTitleColor:BlueBtnColor forState:UIControlStateNormal];
    [self.view addSubview:sift];
    [sift addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)btnAction{
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-100, MAINSCREEN_HEIGHT)];
    window.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:1];
    window.windowLevel = UIWindowLevelNormal;
    window.hidden = NO;
    [window makeKeyAndVisible];
    MGMineMenuVc *up = [[MGMineMenuVc alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:up];
    up.view.frame = window.bounds;
    window.rootViewController = nav;
    self.window = window;
    
    
    
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [view addGestureRecognizer:tap];
    //    [self.view addSubview:view];
    [self.view.window addSubview:view];
    [UIView animateWithDuration:1 animations:^{
        window.frame = CGRectMake(100, 0, MAINSCREEN_WIDTH-100, MAINSCREEN_HEIGHT);
    }];
    
    self.upView = view;
    
    __weak typeof(self) weak = self;
    [up setCancleBarItemHandle:^{
        [UIView animateWithDuration:1 animations:^{
            weak.window.frame = CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-100, MAINSCREEN_HEIGHT);
            [weak.upView removeFromSuperview];
        }];
        
        
        [weak.window resignKeyWindow];
        weak.window  = nil;
        weak.upView = nil;
    }];
}

- (void)tapAction{
    [UIView animateWithDuration:1 animations:^{
        self.window.frame = CGRectMake(MAINSCREEN_WIDTH, 0, MAINSCREEN_WIDTH-100, MAINSCREEN_HEIGHT);
    }];
    [self.upView removeFromSuperview];
    
    [self.window resignKeyWindow];
    self.window  = nil;
    self.upView = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
