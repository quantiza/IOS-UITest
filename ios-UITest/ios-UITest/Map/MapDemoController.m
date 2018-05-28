//
//  MapDemoController.m
//  ios-UITest
//
//  Created by Long Yang on 2018/5/15.
//  Copyright © 2018年 yl. All rights reserved.
//

#import "MapDemoController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface MapDemoController ()

@end

@implementation MapDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self mapConfigure];
}

- (void)createUI {
    self.view.backgroundColor = WHITE_COLOR;
    self.title = @"MapDemo";
}

- (void)mapConfigure {
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    
    //定位蓝点
    mapView.showsUserLocation = YES;
    mapView.userTrackingMode = MAUserTrackingModeFollow;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
