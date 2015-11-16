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

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点
    int _degree;
}
@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation
@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface MapViewController ()
{
    UIButton *startBtn;
    UIButton *followingBtn;
    UIButton *followHeadBtn;
    UIButton *stopBtn;
}
@property (nonatomic,assign) double longitude;
@property (nonatomic,assign) double latitude;
@property (strong) BMKRouteSearch *routeSearcher; //搜索
@property (nonatomic,strong) BMKPoiInfo *poi;
@property (nonatomic,strong) NSString *startPointName;
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

#pragma mark - 更新目的地点信息
- (void)updateEndAddressInfo:(NSNotification *)notifi{
    
    BMKPoiInfo *poi = [notifi object];
    
    self.poi = poi;
    
    [self drawDrivingRoute];
}

#pragma mark - 开始计算路线 (选择目的地点后调用)
- (void)startSearch{
    
    _routeSearcher = [[BMKRouteSearch alloc] init];
    _routeSearcher.delegate = self;
    
    BMKPlanNode *from = [[BMKPlanNode alloc] init];
    from.cityName = @"烟台市";
    from.name = self.startPointName;
    from.pt = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    
    BMKPlanNode *to = [[BMKPlanNode alloc] init];
    to.cityName = @"烟台市";
    to.name = self.poi.name;
    to.pt = self.poi.pt;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc] init];
    drivingRouteSearchOption.from = from;
    drivingRouteSearchOption.to = to;
    
    if ([_routeSearcher drivingSearch:drivingRouteSearchOption]) {
        NSLog(@"驾车路线查询成功");
    }else{
        NSLog(@"驾车路线查询失败");
    }
}

- (void)drawDrivingRoute{
    [self startSearch];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"地图";
    self.view.backgroundColor = BGColor;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(pushSearchView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateEndAddressInfo:) name:@"selectEndAddress" object:nil];
    
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
    [_mapView setScrollEnabled:YES];
    [_mapView setZoomEnabled:YES];
    _mapView.zoomLevel = 15;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self;// 此处记得不用的时候需要置nil，否则影响内存的释放
    locService.delegate = self;
    _routeSearcher.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;// 不用时，置nil
    locService.delegate = nil;
    _routeSearcher.delegate = nil;
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
//    [_mapView setZoomLevel:15];
    
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    self.latitude = userLocation.location.coordinate.latitude;
    self.longitude = userLocation.location.coordinate.longitude;
    self.startPointName = userLocation.title;
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
- (NSString*)getMyBundlePath1:(NSString *)filename
{
    
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}
- (BMKAnnotationView*)getRouteAnnotationView:(BMKMapView *)mapview viewForAnnotation:(RouteAnnotation*)routeAnnotation
{
    BMKAnnotationView* view = nil;
    switch (routeAnnotation.type) {
        case 0:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"start_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"start_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_start.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 1:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"end_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"end_node"];
                view.image = [UIImage imageWithContentsOfFile:[self getMyBundlePath1:@"images/icon_nav_end.png"]];
                view.centerOffset = CGPointMake(0, -(view.frame.size.height * 0.5));
                view.canShowCallout = TRUE;
            }
            view.annotation = routeAnnotation;
        }
            break;
        case 2:
        {
            view = [mapview dequeueReusableAnnotationViewWithIdentifier:@"route_node"];
            if (view == nil) {
                view = [[BMKAnnotationView alloc]initWithAnnotation:routeAnnotation reuseIdentifier:@"route_node"];
                view.canShowCallout = TRUE;
            } else {
                [view setNeedsDisplay];
            }
            
        }
            break;
            
        default:
            break;
    }
    
    return view;
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [self getRouteAnnotationView:view viewForAnnotation:(RouteAnnotation*)annotation];
    }
    return nil;
}

- (BMKOverlayView*)mapView:(BMKMapView *)map viewForOverlay:(id<BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = [[UIColor cyanColor] colorWithAlphaComponent:1];
        polylineView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}
#pragma mark - 搜索驾车路线代理
- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error{
    _routeSearcher.delegate = nil;
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        //*******************
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        //*****************************
        
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 2;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
    
    
}
//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}


/*
 1.http://developer.baidu.com/注册百度地图开发者
 2.申请百度地图key，具体方法百度地图开放平台里面有
 3.下载开发包
 
 
 
 
 
 
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
