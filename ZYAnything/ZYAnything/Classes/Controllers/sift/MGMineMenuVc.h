//
//  MGMineMenuVc.h
//  JDSelectDemo
//
//  Created by mark on 15/8/3.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MGBaseViewController.h"
typedef void (^MGBasicBlock)();
typedef void (^btnStationBlock)();
@interface MGMineMenuVc : MGBaseViewController
- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock;
@end
