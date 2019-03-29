//
//  ViewController.m
//  Runner
//
//  Created by 王加祥 on 2019/3/29.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "ViewController.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterPlatformView.h"
#import "NativeViewFactory.h"
#import "AppDelegate.h"

@interface ViewController ()
/** <#参数#> */
@property (nonatomic,strong) NativeViewFactory *navi;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame    = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 100);
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"点击跳转到Flutter界面" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionForButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)actionForButton {

    NativeViewFactory *navi = [[NativeViewFactory alloc] init];
    self.navi   = navi;

    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    [[flutterViewController registrarForPlugin:@"NativeViewFactory"] registerViewFactory:navi withId:@"NativeView"];
    [flutterViewController setInitialRoute:@"myApp"];
    
    // 要与main.dart中一致
    NSString *channelName = @"com.pages.your/native_get";
    
    FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:flutterViewController];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
        // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
        // result 是给flutter的回调， 该回调只能使用一次
        NSLog(@"method=%@ \narguments = %@", call.method, call.arguments);
        [self.navi setColor:call.arguments[@"title"]];
        
    }];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];
    
}

//json格式字符串转字典：

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
@end
