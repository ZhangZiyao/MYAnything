//
//  SubSelectViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/8.
//  Copyright © 2016年 soez. All rights reserved.
//

#import "SubSelectViewController.h"
#import "UIDefines.h"
#import "SelectBtnTableViewCell.h"

#define kMGLeftSpace 60
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

@interface SubSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SubSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"子菜单"];
    [self setNavBack:@selector(backAction)];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth-kMGLeftSpace, kScreenHeight)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *SureBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    //    UIBarButtonItem *spaceBar = [self spacerWithSpace:110];
    self.navigationItem.rightBarButtonItems = @[SureBarItem];
    // Do any additional setup after loading the view.
}

- (void)cancelAction{
    
//    [self navBackBarAction:nil];
}
- (void)rightAction{
    
    //    [self navBackBarAction:nil];
    NSLog(@"确定筛选条件");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SelectBtnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[SelectBtnTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [@"红色" stringByAppendingString:[NSString stringWithFormat:@"%ld",indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
