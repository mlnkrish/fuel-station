//
//  BeaconDetector.m
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "BeaconDetector.h"


@implementation BeaconDetector

- (void)startMonitoring {
    
    if(!self.isMonitoring) {
        NSLog(@"Begin Monitoring");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6F"];
        self.beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.uuid identifier:@"com.thoughtworks.fuelStation"] ;
        
        [self.locationManager startMonitoringForRegion:self.beaconRegion];
        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
        self.isMonitoring = YES;
    } else {
        NSLog(@"Already Monitoring");
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"error = %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    NSLog(@"Monitoring started");
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"monitoringDidFailForRegion");
    NSLog(@"error = %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"Entered region");
    [self.locationManager startRangingBeaconsInRegion:(CLBeaconRegion *)region];
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"Exitted region");
    
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
    NSLog(@"Ranged a bunch of beacons %@", region);
    NSLog(@"Count : %i", [beacons count]);
    if ([beacons count] > 0) {
        CLBeacon *closestBeacon = [beacons objectAtIndex:0];
        BeaconAwareViewController *current =[CurrentViewHolder get];
        [current beaconDetected:closestBeacon];
    } else {
        BeaconAwareViewController *current =[CurrentViewHolder get];
        [current beaconLost];
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    NSLog(@"Region state determined %i",state);
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error {
    NSLog(@"ranging Beacons Did Fail For Region");
    NSLog(@"error = %@",error);
    if ([CLLocationManager isRangingAvailable]) {
        NSLog(@"Ranging is available");
    } else {
        NSLog(@"Ranging not available");
    }
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    NSLog(@"locationManagerDidPauseLocationUpdates");
}
@end
