//
//  AppDelegate.m
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconDetector.h"
#import "CurrentUserHolder.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.detector = [[BeaconDetector alloc] init];
    [self.detector startMonitoring];
    

    int r = arc4random() % 9999;
    NSString *token = [NSString stringWithFormat:@"%i", r];
    [CurrentUserHolder setToken:token];
    NSLog(@"TOKEN : %@", token);
    self.broadcaster = [[BeaconBroadcaster alloc] init];
    [self.broadcaster startBroadcasting];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self.broadcaster stopBroadcasting];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    int r = arc4random() % 9999;
    NSString *token = [NSString stringWithFormat:@"%i", r];
    [CurrentUserHolder setToken:token];
    NSLog(@"TOKEN : %@", token);
    [self.broadcaster startBroadcasting];
    [[[CurrentViewHolder get] navigationController] popToRootViewControllerAnimated:false];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
