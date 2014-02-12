//
//  BeaconBroadcaster.m
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "BeaconBroadcaster.h"

@implementation BeaconBroadcaster

- (void)startBroadcasting {

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6G"];
    self.myBeaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                  major:2046
                                                                  minor:1
                                                             identifier:@"com.thoughtworks.fuelStation.user"];
    self.myBeaconData = [self.myBeaconRegion peripheralDataWithMeasuredPower:nil];
    self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self
                                                                     queue:nil
                                                                   options:nil];
    
}

- (void)stopBroadcasting {
    if (self.isBroadcasting) {
        NSLog(@"Stopping broadcast");
        [self.peripheralManager stopAdvertising];
        self.isBroadcasting = NO;
    } else {
        NSLog(@"Cannot stop, not braodcasting currently");
    }
}

-(void)peripheralManagerDidUpdateState:(CBPeripheralManager*)peripheral {
    if (peripheral.state == CBPeripheralManagerStatePoweredOn) {
        if(!self.isBroadcasting) {
            NSLog(@"Starting to broadcast");
            [self.peripheralManager startAdvertising:self.myBeaconData];
            self.isBroadcasting = YES;
        } else {
            NSLog(@"already broadcasting");
        }
    }
    else if (peripheral.state == CBPeripheralManagerStatePoweredOff) {
        NSLog(@"Stopping broadcast");
        [self.peripheralManager stopAdvertising];
        self.isBroadcasting = NO;
    }
    else if (peripheral.state == CBPeripheralManagerStateUnsupported) {
        NSLog(@"Cannot broadcast");
    }
}

@end
