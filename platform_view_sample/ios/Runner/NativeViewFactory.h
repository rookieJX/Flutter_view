//
//  NativeViewFactory.h
//  Runner
//
//  Created by 王加祥 on 2019/3/29.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import "BaiDuView.h"


@interface NativeViewFactory : NSObject<FlutterPlatformViewFactory>
- (void)setColor:(NSString *)string;
@end

@interface NativeView : NSObject<FlutterPlatformView>
- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger;

/** 描述 */
@property (nonatomic,strong) UILabel * indicatorLabel;
/** 按钮 */
@property (nonatomic,strong) UIButton * indicatorButton;
/** 百度地图 */
@property (nonatomic,strong) BaiDuView * baiduView;
@end


