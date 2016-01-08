//
//  ControlsViewController.h
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/8.
//  Copyright © 2016年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"

typedef void (^BasicBlock)();
typedef void (^btnStationBlock)();
@interface ControlsViewController : UITableViewController<RETableViewManagerDelegate>

@property (strong, readonly, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *basicControlsSection;

- (void)setCancleBarItemHandle:(BasicBlock)basicBlock;

@end
