//
//  MapViewController.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/15.
//  Copyright © 2015年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    BMKLocationService *locService;
}

@property (nonatomic,strong) BMKMapView *mapView;

@end
