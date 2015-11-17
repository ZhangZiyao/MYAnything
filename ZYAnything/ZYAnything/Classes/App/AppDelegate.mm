//
//  AppDelegate.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/13.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "PilotView.h"

BMKMapManager *_mapManager;
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    //填写你在百度开放平台申请的AK
    BOOL ret = [_mapManager start:@"CDx2fHOMdClPedvYXicPLrBE" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    ViewController *mainVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    //增加标识，判断应用是否是第一次启动
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"first"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"first"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"first"]) {
        PilotView *pilotView = [[PilotView alloc] init];
        [self.window addSubview:pilotView];
    }else{
        
    }
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //将应用即将后台是调用，停止一切调用openGL相关的操作
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //当应用恢复前台状态时调用
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

#pragma mark -
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}
@end
