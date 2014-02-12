//
//  BeaconDetector.h
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <TSMessage.h>
#import "CurrentViewHolder.h"

@interface BeaconDetector : NSObject<CLLocationManagerDelegate>

@property CLBeaconRegion *beaconRegion;
@property CLLocationManager *locationManager;
@property NSUUID *uuid;
@property BOOL isMonitoring;

- (void)startMonitoring;

@end
