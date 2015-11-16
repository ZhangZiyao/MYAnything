//
//  MapViewController.m
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/15.
//  Copyright © 2015年 soez. All rights reserved.
//

#import "MapViewController.h"
#import "UIDefines.h"
#import "POISearchViewController.h"

@interface MapViewController ()
{
    UIButton *startBtn;
    UIButton *followingBtn;
    UIButton *followHeadBtn;
    UIButton *stopBtn;
}
@end

@implementation MapViewController
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

#pragma mark - 禁止横屏
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)pushSearchView{
    POISearchViewController *poiSearchVc = [[POISearchViewController alloc] init];
    [self.navigationController pushViewController:poiSearchVc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
    self.view.backgroundColor = BGColor;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(pushSearchView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    [self initMapView];
    //初始化定位服务
    locService = [[BMKLocationService alloc] init];
    
    
    UIView *sView = [[UIView alloc] initWithFrame:CGRectMake(0, MAINSCREEN_HEIGHT-50, MAINSCREEN_WIDTH, 50)];
    [self.view addSubview:sView];
//    sView.backgroundColor = GreenBtnColor;
    
    startBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    [startBtn setTitle:@"定位" forState:UIControlStateNormal];
    [startBtn setBackgroundColor:GreenBtnColor];
    [sView addSubview:startBtn];
    [startBtn addTarget:self action:@selector(startLocation) forControlEvents:UIControlEventTouchUpInside];
    
    followingBtn = [[UIButton alloc] initWithFrame:CGRectMake(80, 0, 80, 40)];
    [followingBtn setTitle:@"跟随" forState:UIControlStateNormal];
    [followingBtn setBackgroundColor:GreenBtnColor];
    [sView addSubview:followingBtn];
    [followingBtn addTarget:self action:@selector(startFollowing) forControlEvents:UIControlEventTouchUpInside];
    
    followHeadBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, 0, 80, 40)];
    [followHeadBtn setTitle:@"罗盘" forState:UIControlStateNormal];
    [followHeadBtn setBackgroundColor:GreenBtnColor];
    [sView addSubview:followHeadBtn];
    [followHeadBtn addTarget:self action:@selector(startFollowHeading) forControlEvents:UIControlEventTouchUpInside];
    
    stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(240, 0, 80, 40)];
    [stopBtn setTitle:@"停止定位" forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:GreenBtnColor];
    [sView addSubview:stopBtn];
    [stopBtn addTarget:self action:@selector(stopLocation) forControlEvents:UIControlEventTouchUpInside];
}

//罗盘态
-(void)startFollowHeading
{
    NSLog(@"进入罗盘态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(void)startFollowing
{
    NSLog(@"进入跟随态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
-(void)stopLocation
{
    [locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
    [stopBtn setEnabled:NO];
    [stopBtn setAlpha:0.6];
    [followHeadBtn setEnabled:NO];
    [followHeadBtn setAlpha:0.6];
    [followingBtn setEnabled:NO];
    [followingBtn setAlpha:0.6];
    [startBtn setEnabled:YES];
    [startBtn setAlpha:1.0];
}

#pragma mark - 初始化地图控件
- (void)initMapView{
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, MAINSCREEN_WIDTH, MAINSCREEN_HEIGHT-50)];
    [self.view addSubview:_mapView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
    locService.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;// 不用时，置nil
    locService.delegate = nil;
}

#pragma mark - 开始定位
- (void)startLocation{
    [locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [startBtn setEnabled:NO];
    [startBtn setAlpha:0.6];
    [stopBtn setEnabled:YES];
    [stopBtn setAlpha:1.0];
    [followHeadBtn setEnabled:YES];
    [followHeadBtn setAlpha:1.0];
    [followingBtn setEnabled:YES];
    [followingBtn setAlpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
    _mapView.centerCoordinate = userLocation.location.coordinate;
    [_mapView setZoomLevel:15];
    
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

/*
 使用v2.9.1版本
 
1. 由于系统原因，iOS不允许使用第三方定位，因此地图SDK中的定位方法，本质上是对原生定位的二次封装。通过封装，开发者可更便捷的使用。此外，地图SDK中还提供了相应的定位图层（支持定位三态效果），帮助开发者显示当前位置信息。
 注：自iOS8起，系统定位功能进行了升级，SDK为了实现最新的适配，自v2.5.0起也做了相应的修改，开发者在使用定位功能之前，需要在info.plist里添加（以下二选一，两个都添加默认使用NSLocationWhenInUseUsageDescription）：
 NSLocationWhenInUseUsageDescription ，允许在前台使用时获取GPS的描述
 NSLocationAlwaysUsageDescription ，允许永久使用GPS的描述
 
 2.百度地图 iOS SDK 采用分包的形式提供 .framework包，请广大开发者使用时确保各分包的版本保持一致。其中BaiduMapAPI_Base.framework为基础包，使用SDK任何功能都需导入，其他分包可按需导入。
 将所需的BaiduMapAPI_**.framework拷贝到工程所在文件夹下。
 在 TARGETS->Build Phases-> Link Binary With Libaries中点击“+”按钮，在弹出的窗口中点击“Add Other”按钮，选择BaiduMapAPI_**.framework添加到工程中。
 注: 静态库中采用Objective-C++实现，因此需要您保证您工程中至少有一个.mm后缀的源文件(您可以将任意一个.m后缀的文件改名为.mm)，或者在工程属性中指定编译方式，即将Xcode的Project -> Edit Active Target -> Build -> GCC4.2 - Language -> Compile Sources As设置为"Objective-C++"
 
 3.百度地图SDK中提供了定位功能和动画效果，v2.0.0版本开始使用OpenGL渲染，因此您需要在您的Xcode工程中引入CoreLocation.framework和QuartzCore.framework、OpenGLES.framework、SystemConfiguration.framework、CoreGraphics.framework、Security.framework、libsqlite3.0.tbd（xcode7以前为 libsqlite3.0.dylib）、CoreTelephony.framework 、libstdc++.6.0.9.tbd（xcode7以前为libstdc++.6.0.9.dylib）。
 添加方式：在Xcode的Project -> Active Target ->Build Phases ->Link Binary With Libraries，添加这几个系统库即可。
 4.在TARGETS->Build Settings->Other Linker Flags 中添加-ObjC。
 5.如果使用了基础地图功能，需要添加该资源，否则地图不能正常显示mapapi.bundle中存储了定位、默认大头针标注View及路线关键点的资源图片，还存储了矢量地图绘制必需的资源文件。如果您不需要使用内置的图片显示功能，则可以删除bundle文件中的image文件夹。您也可以根据具体需求任意替换或删除该bundle中image文件夹的图片文件。
 方法：选中工程名，在右键菜单中选择Add Files to “工程名”…，从BaiduMapAPI_Map.framework||Resources文件中选择mapapi.bundle文件，并勾选“Copy items if needed”复选框，单击“Add”按钮，将资源文件添加到工程中。
 
 */
@end
