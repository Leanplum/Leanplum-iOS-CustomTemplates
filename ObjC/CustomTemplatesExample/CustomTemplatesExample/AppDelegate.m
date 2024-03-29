//
//  AppDelegate.m
//  CustomTemplatesExample
//
//  Created by Nikola Zagorchev on 12.06.20.
//  Copyright © 2022 Nikola Zagorchev. All rights reserved.
//

#import "AppDelegate.h"
#import "Leanplum.h"
#import "AlertWith3Buttons.h"
#import "SliderMessageTemplate.h"
#import "LPAdsAskToAskMessageTemplate.h"
#import "LPAdsTrackingActionTemplate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString *appId = @"app_";
    NSString *devKey = @"dev_";
    
    [Leanplum setAppId: appId withDevelopmentKey: devKey];
            
    [AlertWith3Buttons defineAction];
    [SliderMessageTemplate defineAction];
    [LPAdsAskToAskMessageTemplate defineAction];
    [LPAdsTrackingActionTemplate defineAction];
            
    [Leanplum setLogLevel:LPLogLevelDebug];
    [Leanplum start];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options  API_AVAILABLE(ios(13.0)){
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions  API_AVAILABLE(ios(13.0)){
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end
