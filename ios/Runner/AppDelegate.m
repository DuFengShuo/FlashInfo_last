#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <RangersAppLog/BDAutoTrack.h>
#import <RangersAppLog/BDAutoTrackConfig.h>
#import <RangersAppLog/BDCommonEnumDefine.h>
#import <RangersAppLog/BDAutoTrackSchemeHandler.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import "AppsflyerSdkPlugin.h"
#import <AdSupport/AdSupport.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    BDAutoTrackConfig *config = [BDAutoTrackConfig configWithAppID: @"10000025"];

    config.appName = @"flashinfo";
    config.channel = @"App Store";

    /* 设置私有部署服务器地址 */
    config.serviceVendor = BDAutoTrackServiceVendorPrivate;
    BDAutoTrackRequestHostBlock block =
        ^NSString *(BDAutoTrackServiceVendor vendor, BDAutoTrackRequestURLType requestURLType){
            return @"https://analytics.sesisngle.net";   // 此处为私有部署服务器地址
        };
    [BDAutoTrack setRequestHostBlock:block];

    [BDAutoTrack startTrackWithConfig:config];
 
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
//    if (@available(iOS 14, *)) {
//        //权限申请
//        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//
//        }];
//    }
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [self idfa];
//  if (@available(iOS 14, *)) {
//  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
//      switch (status) {
//          case ATTrackingManagerAuthorizationStatusNotDetermined:
//
//              break;
//          default:
//              break;
//      }
//  }];
//  } else {
//
//  }
}
- (NSString*)idfa {
    __block NSString *idfa = @"";
    ASIdentifierManager *manager = [ASIdentifierManager sharedManager];
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                idfa = [[manager advertisingIdentifier] UUIDString];
            }
        }];
    }else{
        if ([manager isAdvertisingTrackingEnabled]) {
            idfa = [[manager advertisingIdentifier] UUIDString];
        }
    }
    return idfa;
}
//如果是iOS 13，重写UISceneDelegate的回调方法
- (void)scene:(UIScene *)scene openURLContexts:(NSSet<UIOpenURLContext *> *)URLContexts  API_AVAILABLE(ios(13.0)){
    for (UIOpenURLContext *context in URLContexts) {
        NSURL *URL = context.URL;
        if ([[BDAutoTrackSchemeHandler sharedHandler] handleURL:URL appID:@"10000025" scene:scene]) {
            continue;
        }

    }
}

//    如果iOS版本低于13，则重写UIApplicationDelegate的回调方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    if ([[BDAutoTrackSchemeHandler sharedHandler] handleURL:url appID:@"10000025" scene:nil]) {
        return YES;
    }

    return NO;
}
// Reports app open from a Universal Link for iOS 9 or above
- (BOOL) application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    [[AppsFlyerAttribution shared] continueUserActivity:userActivity restorationHandler:restorationHandler];
    return YES;
  }
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation {
    [[AppsFlyerAttribution shared] handleOpenUrl:url sourceApplication:sourceApplication annotation:annotation];
  return YES;
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_6_0

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAll;
}

#endif
@end
