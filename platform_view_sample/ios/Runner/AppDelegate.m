#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterPlatformView.h"
#import "NativeViewFactory.h"

#import "ViewController.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>


@interface AppDelegate ()
@property (nonatomic,strong) BMKMapManager *mapManager;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController  = nav;
    
    //设置百度地图
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"Nl7xeLvGU39e0DvUBdGMX6rDjGKpFsFj" generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [BMKMapManager setCoordinateTypeUsedInBaiduMapSDK: BMK_COORDTYPE_COMMON];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
