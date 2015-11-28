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
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //将应用即将后台是调用，停止一切调用openGL相关的操作
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}
#pragma mark 进入前台后设置消息信息
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //进入前台取消应用消息图标
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //当应用恢复前台状态时调用
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    if (notificationSettings.types!=UIUserNotificationTypeNone) {
        [self addLocalNotification];
    }
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

#pragma mark - 私有方法
#pragma mark 添加本地通知
-(void)addLocalNotification{
    
    //定义本地通知对象
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
    notification.repeatInterval=2;//通知重复次数
    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间
    
    //设置通知属性
    notification.alertBody=@"超过2分钟没有司机接单，换个车型？"; //通知主体
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
//    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
    
    //设置用户信息
    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
@end
