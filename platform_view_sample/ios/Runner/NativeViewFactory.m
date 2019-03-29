//
//  NativeViewFactory.m
//  Runner
//
//  Created by 王加祥 on 2019/3/29.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "NativeViewFactory.h"



@interface NativeViewFactory()
/** 参数 */
@property (nonatomic,strong) NativeView *activity;
@end

@implementation NativeViewFactory{
    NSObject<FlutterBinaryMessenger>*_messenger;
}

- (void)setColor:(NSString *)string {
    NSLog(@"%@",string);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activity.indicatorLabel.text   = string;
    });
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

- (NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame
                                   viewIdentifier:(int64_t)viewId
                                        arguments:(id _Nullable)args {
    NativeView *activity = [[NativeView alloc] initWithWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:_messenger];
    self.activity   = activity;
    return activity;
    
}
@end

@interface NativeView ()
/** 引用 */
@property (nonatomic,strong) UIView * indicator;
@end

@implementation NativeView{
    int64_t _viewId;
    FlutterMethodChannel* _channel;
}

- (instancetype)initWithWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id)args binaryMessenger:(NSObject<FlutterBinaryMessenger> *)messenger{
    if ([super init]) {
        _indicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 380, 500)];
        _indicator.backgroundColor  = [UIColor blueColor];
        
        _indicatorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 360, 100)];
        _indicatorLabel.backgroundColor   = [UIColor orangeColor];
        _indicatorLabel.textAlignment   = NSTextAlignmentCenter;
        _indicatorLabel.text  = @"这里是iOS原生界面";
        [_indicator addSubview:_indicatorLabel];
        
        _indicatorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _indicatorButton.frame  = CGRectMake(10, 120, 360, 100);
        _indicatorButton.backgroundColor    = [UIColor magentaColor];
        [_indicatorButton setTitle:@"这里是iOS原生按钮" forState:UIControlStateNormal];
        [_indicatorButton addTarget:self action:@selector(actionForButton) forControlEvents:UIControlEventTouchUpInside];
        [_indicator addSubview:_indicatorButton];
        
        _baiduView  = [[BaiDuView alloc] initWithFrame:CGRectMake(10, 230, 360, 260)];
        [_indicator addSubview:_baiduView];
        
        _viewId = viewId;
    }
    return self;
}

-(UIView *)view {
    return _indicator;
}


- (void)actionForButton {
    NSLog(@"点击了原生按钮");
    self.indicatorLabel.text    = @"点击了iOS原生按钮";
}

@end
