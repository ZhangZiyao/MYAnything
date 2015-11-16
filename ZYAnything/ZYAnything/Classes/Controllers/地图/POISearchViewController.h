//
//  POISearchViewController.h
//  ZYAnything
//
//  Created by ZhangZiyao on 15/11/16.
//  Copyright © 2015年 soez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface POISearchViewController : UIViewController<BMKPoiSearchDelegate>
{
    BMKPoiSearch *poiSearch;
}
@end
