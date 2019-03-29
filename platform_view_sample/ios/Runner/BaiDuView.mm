//
//  BaiDuView.m
//  Runner
//
//  Created by 王加祥 on 2019/3/29.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "BaiDuView.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface BaiDuView ()<BMKMapViewDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@end

@implementation BaiDuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor grayColor];
        _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _mapView.delegate = self;
        [self addSubview:_mapView];
    }
    return self;
}
@end
