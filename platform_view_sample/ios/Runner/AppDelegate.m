#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "FlutterPlatformView.h"
#import "NativeViewFactory.h"

#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    self.window.rootViewController  = nav;
    
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
