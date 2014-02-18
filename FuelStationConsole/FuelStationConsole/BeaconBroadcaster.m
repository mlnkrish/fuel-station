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
            NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6F"];
            self.ad = [[BeaconAdvertisementData alloc] initWithProximityUUID:uuid
                                                                        major:1
                                                                        minor:1
                                                                        measuredPower:-58];
            
            [self.peripheralManager startAdvertising:self.ad.beaconAdvertisement];
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
