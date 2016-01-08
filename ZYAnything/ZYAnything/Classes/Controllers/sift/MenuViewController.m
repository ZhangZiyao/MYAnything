//
//  MenuViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/8.
//  Copyright © 2016年 soez. All rights reserved.
//

#import "MenuViewController.h"
#import "SubSelectViewController.h"
#import "UIDefines.h"
#import "SelectBtnTableViewCell.h"

#define kMGLeftSpace 60
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) MGBasicBlock basicBlock;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitle;

@property (nonatomic, copy) btnStationBlock btnStationBlock;
@property (nonatomic) int todyBtnStation;
@property (nonatomic) int saleBtnStation;
@property (nonatomic) int hotBtnStation;
@property (nonatomic) int killBtnStation;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _todyBtnStation = 1;
    [self setNavColor];
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    [cancelBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = cancelBarItem;
    //    self.navigationItem.title = @"筛选";
    
    UIBarButtonItem *SureBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    //    UIBarButtonItem *spaceBar = [self spacerWithSpace:30];
    [SureBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems = @[SureBarItem];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth-kMGLeftSpace, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
    self.arrTitle = @[@[@"订单状态",@"订单类型",@"目的地"]];
}

- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock{
    
    self.basicBlock = basicBlock;
}

- (void)cancelAction{
    
    if(self.basicBlock)self.basicBlock();
    
}
- (void)rightAction{
    
    //    if(self.basicBlock)self.basicBlock();
    NSLog(@"确定");
    NSLog(@"%d,%d,%d,%d",_todyBtnStation,_saleBtnStation,_hotBtnStation,_killBtnStation);
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrTitle.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.arrTitle[section];
    return arr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSArray *arr = self.arrTitle[indexPath.section];
    cell.textLabel.text = arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 5;//0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SubSelectViewController *svc = [[SubSelectViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
