//
//  AppDelegate.h
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconDetector.h"
#import "BeaconBroadcaster.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property BeaconDetector *detector;
@property BeaconBroadcaster *broadcaster;

@end
