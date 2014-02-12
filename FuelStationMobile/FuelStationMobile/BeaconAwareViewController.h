//
//  BeaconAwareViewController.h
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface BeaconAwareViewController : UIViewController

- (void) beaconDetected:(CLBeacon *)beacon;

- (void) beaconLost;


@end
