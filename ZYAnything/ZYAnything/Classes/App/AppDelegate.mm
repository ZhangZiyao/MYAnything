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


/*
 - (void)application:(UIApplication *)app didReceiveRemoteNotification:(NSDictionary *)userInfo
 {
 //取未读count
 [self refreshAppCount];
 #ifdef DEBUG
 NSLog(@"received aps while running, userInfo=%@", userInfo);
 #endif
 NSLog(@"received aps while running, userInfo=%@", userInfo);
 
 if (userInfo == nil) {
 return;
 }
 
 
 //有推送， 在becomeActivity中不检查更新
 _isAwakenFromeMessagePush = YES;
 
 NSString *module = [userInfo objectForKey:@"module"];
 NSString *strId = [userInfo objectForKey:@"id"];
 self.apsReleationId = strId && strId.length > 0 ? strId : @"0";
 NSDictionary *aps = [userInfo objectForKey:@"aps"];
 UIApplicationState currentState = [UIApplication sharedApplication].applicationState;
 
 
 if (currentState == UIApplicationStateActive) {
 [self playAlertSound];
 UIAlertView *alert;
 //active
 if ([module isEqualToString:MODULE_CASE]) {
 alert = [[UIAlertView alloc] initWithTitle:@"您的咨询有新回复" message:[NSString stringWithFormat:@"%@ 是否要跳转到您的咨询列表?", [aps objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"一会儿再说" otherButtonTitles:@"转到我的咨询", nil];
 [alert setTag:TAG_CASE];
 [alert show];
 } else if ([module isEqualToString:MODULE_MSG]) {
 //进站内信
 alert = [[UIAlertView alloc] initWithTitle:@"您有新消息" message:[aps objectForKey:@"alert"] delegate:self cancelButtonTitle:@"忽略" otherButtonTitles:@"查看", nil];
 alert.apsID = [userInfo stringForKey:@"cm"];
 _msgTitle = [userInfo stringForKey:@"cmTitle"];
 [alert setTag:TAG_APS];
 [alert show];
 }
 else if ([module isEqualToString:MODULE_CONVERSATION]) {
 //进医生群组
 [UIAlertView showWithTitle:@"你有新消息" message:[aps objectForKey:@"alert"] cancelButtonTitle:@"忽略" otherButtonTitles:@[@"查看"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
 if (buttonIndex == 1) {
 [self pushConvsationChatVCWithConversationId:[userInfo objectForKey:@"id"]];
 }
 }];
 }else if([module isEqualToString:MODULE_BOOKINGDETAIL]){
 //进站内信详情
 self.apsReleationId = [userInfo stringForKey:@"cm"];
 _msgTitle = [userInfo stringForKey:@"cmTitle"];
 __weak AppDelegate *weakSelf = self;
 [UIAlertView showWithTitle:@"您有新消息" message:[aps objectForKey:@"alert"] cancelButtonTitle:@"忽略" otherButtonTitles:@[@"查看"] tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
 if (buttonIndex == 1) {
 [weakSelf pushMsgViewController];
 }
 }];
 }else if (currentState == UIApplicationStateBackground || currentState == UIApplicationStateInactive) {
 //background or inactive
 if ([module isEqualToString:MODULE_CASE]) {
 self.tabBarController.selectedIndex = TABBAR_INDEX_MY;
 UINavigationController *nc = (UINavigationController *)self.tabBarController.selectedViewController;
 HDFMyInfoViewController *mvc = [nc.viewControllers objectAtIndex:0];
 [mvc pushToCaseOrderListViewController];
 } else if ([module isEqualToString:MODULE_MSG]) {
 //进站内信
 self.apsReleationId = [userInfo stringForKey:@"cm"];
 _msgTitle = [userInfo stringForKey:@"cmTitle"];
 [self pushMsgViewController];
 }else if ([module isEqualToString:MODULE_CONVERSATION]) {
 //进医生群组
 [self pushConvsationChatVCWithConversationId:[userInfo objectForKey:@"id"]];
 }else if([module isEqualToString:MODULE_BOOKINGDETAIL]){
 //进订单详情 ； 5-28 服务端无法兼容老版本， 修改为推送到 订单详情页
 self.apsReleationId = [userInfo stringForKey:@"cm"];
 _msgTitle = [userInfo stringForKey:@"cmTitle"];
 [self pushMsgViewController];
 }
 
 else if([module isEqualToString:MODULE_MEDICINEDIARY]){
 //用药日记
 NSString *userId = [userInfo objectForKey:@"userid"];
 if (![userId isEqualToString:[HaodfUserManager sharedManager].userIdString]) return;    //非当前用户
 
 NSString *childModule = [userInfo objectForKey:@"cm"];
 NSString *patientId = [userInfo objectForKey:@"pid"];
 NSString *patientName = [userInfo objectForKey:@"pn"];
 
 if ([childModule isEqualToString:@"v"]) {                //剩余药量
 [self pushMedicationDiaryDetailViewControllerWithPatientId:patientId patientName:patientName showChestRedDot:YES notificationName:childModule];
 }
 else if ([childModule isEqualToString:@"ano"]) {        //添加批注
 [self pushMedicationDiaryDetailViewControllerWithPatientId:patientId patientName:patientName showChestRedDot:NO notificationName:childModule];
 }
 else if ([childModule isEqualToString:@"am"]) {   //添加药物成功
 [self pushMedicationDiaryDetailViewControllerWithPatientId:patientId patientName:patientName showChestRedDot:YES notificationName:childModule];
 }
 }
 }
 
 
 */
