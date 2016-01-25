//
//  ControlsViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/8.
//  Copyright © 2016年 soez. All rights reserved.
//

#import "ControlsViewController.h"
#import "UIDefines.h"

@interface ControlsViewController ()
@property (strong, readwrite, nonatomic) RERadioItem *radioItem;
@property (strong, readwrite, nonatomic) REMultipleChoiceItem *multipleChoiceItem;
@property (nonatomic, copy) BasicBlock basicBlock;
@end

@implementation ControlsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Controls";
    [self setNavColor];
    [self setNavBack:@selector(backAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Values" style:UIBarButtonItemStylePlain target:self action:@selector(valuesButtonPressed:)];
    
    UIBarButtonItem *cancelBarItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelAction)];
    [cancelBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem = cancelBarItem;
    //    self.navigationItem.title = @"筛选";
    
    UIBarButtonItem *SureBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    [SureBarItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItems = @[SureBarItem];
    
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    // Create manager
    //
    _manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicControlsSection = [self addBasicControls];
}

- (void)valuesButtonPressed:(id)sender
{
    NSLog(@"radioItem.value = %@", self.radioItem.value);
    NSLog(@"multipleChoiceItem.value = %@", self.multipleChoiceItem.value);
}

#pragma mark -
#pragma mark Basic Controls Example

- (RETableViewSection *)addBasicControls
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"筛选订单"];
    [_manager addSection:section];
    
    // Add items to this section
    NSMutableArray *options = [[NSMutableArray alloc] initWithObjects:@"已提交",@"已接单",@"执行中",@"待付款",@"已完结",@"异常", nil];
    
    self.radioItem = [RERadioItem itemWithTitle:@"订单状态" value:@"" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        // Present options controller
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    NSMutableArray *options2 = [[NSMutableArray alloc] initWithObjects:@"天安门",@"首都机场",@"北京南站",@"故宫",@"老北京炸酱面",@"北京火车站", nil];
    
    self.multipleChoiceItem = [REMultipleChoiceItem itemWithTitle:@"目的地点" value:@[] selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        //
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options2 multipleChoice:YES completionHandler:^{
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"%@", item.value);
        }];
        
        // Adjust styles
        //
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        // Push the options controller
        //
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    [section addItem:self.radioItem];
    [section addItem:self.multipleChoiceItem];
    
    
    return section;
}

- (void)setCancleBarItemHandle:(BasicBlock)basicBlock{
    
    self.basicBlock = basicBlock;
}

- (void)cancelAction{
    
    if(self.basicBlock)self.basicBlock();
    
}
- (void)rightAction{
    
    //    if(self.basicBlock)self.basicBlock();
    NSLog(@"确定");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
