//
//  MenuViewController.h
//  ZYAnything
//
//  Created by ZhangZiyao on 16/1/8.
//  Copyright © 2016年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^MGBasicBlock)();
typedef void (^btnStationBlock)();
@interface MenuViewController : UIViewController

- (void)setCancleBarItemHandle:(MGBasicBlock)basicBlock;

@end
