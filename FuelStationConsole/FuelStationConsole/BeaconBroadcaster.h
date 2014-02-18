//
//  BeaconBroadcaster.h
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "BeaconAdvertisementData.h"

@interface BeaconBroadcaster : NSObject<CBPeripheralManagerDelegate>

@property (strong, nonatomic) CBPeripheralManager *peripheralManager;
@property BOOL isBroadcasting;
@property BeaconAdvertisementData *ad;

- (void)startBroadcasting;
- (void)stopBroadcasting;

@end
