//
//  AppDelegate.m
//  AppleApplication
//
//  Created by Eddie Hillenbrand on 11/16/16.
//  Copyright © 2016 Eddie Hillenbrand. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

#if defined(VT_USE_CONFIG) && VT_USE_CONFIG
    NSLog(@"use config");
#else
    NSLog(@"not using config");
#endif

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}


@end
