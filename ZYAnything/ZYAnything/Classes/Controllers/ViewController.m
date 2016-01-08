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
#import "MyBlogViewController.h"
#import "SiftViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_btnNameArray;
    NSArray *_viewControllerArray;
}

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavColor];
    [self setNavTitle:@"Anything"];
    
    
    self.view.backgroundColor = BGColor;
//    [self makeUI];
    
    _btnNameArray = @[@"访问相册",@"地图/定位",@"二维码",@"我的博客",@"筛选",@"音乐播放器",@"视频播放器"];
    _viewControllerArray = [[NSArray alloc] initWithObjects:
                            @"VisitPhotoViewController",
                            @"MapViewController",
                            @"QRCodeViewController",
                            @"MyBlogViewController",
                            @"SiftViewController",
                            @"MusicPlayerViewController",
                            @"VideoPlayerViewController",
                            nil];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idStr];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idStr];
    }
    cell.textLabel.text = [_btnNameArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    [viewController setNavTitle:[_btnNameArray objectAtIndex:indexPath.row]];
    [viewController setNavBack:@selector(backAction)];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _btnNameArray.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
