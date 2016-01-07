//
//  MGMineMenuVc.m
//  JDSelectDemo
//
//  Created by mark on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGMineMenuVc.h"
#import "MGSubSelectVc.h"
#import "UIDefines.h"
#import "SelectBtnTableViewCell.h"


#define kMGLeftSpace 60
//屏幕高度
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
//屏幕宽
#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
@interface MGMineMenuVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, copy) MGBasicBlock basicBlock;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitle;

@property (nonatomic, copy) btnStationBlock btnStationBlock;
@property (nonatomic) int todyBtnStation;
@property (nonatomic) int saleBtnStation;
@property (nonatomic) int hotBtnStation;
@property (nonatomic) int killBtnStation;


@end

@implementation MGMineMenuVc

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"筛选";
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
    self.arrTitle = @[@[@"配送至"],@[@"订单状态",@"订单类型",@"目的地"]];
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
    if(0 == indexPath.section)
    {
        return 100;
    }else
    {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(0 == indexPath.section)
    {
        SelectBtnTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"selectBtnCell"];
        if(nil == cell)
        {
            cell = [[SelectBtnTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"selectBtnCell"];
//            cell = [[[NSBundle mainBundle]loadNibNamed:@"selectBtnCell" owner:self options:nil] lastObject];
//            cell.callBack = ^(int i1 ,int i2 ,int i3 ,int i4)
//            {
////                NSLog(@"%d,%d,%d,%d",i1,i2,i3,i4);
//                _todyBtnStation = i1;
//                _saleBtnStation = i2;
//                _hotBtnStation = i3;
//                _killBtnStation = i4;
//                
//            };
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else
    {
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
//    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5;//0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    MGSubSelectVc *svc = [[MGSubSelectVc alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
