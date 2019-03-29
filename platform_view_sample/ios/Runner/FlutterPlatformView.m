//
//  FlutterPlatformView.m
//  Runner
//
//  Created by 王加祥 on 2019/3/29.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FlutterPlatformView.h"
@implementation FlutterActivityIndicatorFactory{
    NSObject<FlutterBinaryMessenger>*_messenger;
}

- (instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger> *)messager{
    self = [super init];
    if (self) {
        _messenger = messager;
    }
    return self;
}

-(NSObject<FlutterMessageCodec> *)createArgsCodec{
    return [FlutterStandardMessageCodec sharedInstance];
}

-(NSObject<FlutterPlatformView> *)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args{
    
    FlutterActivityIndicatorController*activity = [[FlutterActivityIndicatorController alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    
    return activity;
    
}

@end

@implementation FlutterActivityIndicatorController{
    int64_t _viewId;
    FlutterMethodChannel* _channel;
    UIView * _indicator;
}

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        
        _indicator = [[UIView alloc] initWithFrame:frame];
        _indicator.backgroundColor = [UIColor orangeColor];
        
        _viewId = viewId;
        NSString* channelName = [NSString stringWithFormat:@"plugins/activity_indicator_%lld", viewId];
        _channel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:messenger];
        __weak __typeof__(self) weakSelf = self;
        [_channel setMethodCallHandler:^(FlutterMethodCall *  call, FlutterResult  result) {
            [weakSelf onMethodCall:call result:result];
        }];
        
    }
    
    return self;
}

-(UIView *)view{
    return _indicator;
}

-(void)onMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result{
    if ([[call method] isEqualToString:@"start"]) {
        _indicator.backgroundColor  = [UIColor blackColor];
    }else
        if ([[call method] isEqualToString:@"stop"]){
            _indicator.backgroundColor  = [UIColor blueColor];
        }
        else {
            result(FlutterMethodNotImplemented);
        }
}


@end
