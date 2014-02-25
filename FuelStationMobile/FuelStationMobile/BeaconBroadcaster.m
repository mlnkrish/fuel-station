//
//  BeaconBroadcaster.m
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "BeaconBroadcaster.h"
#import "CurrentUserHolder.h"

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
            NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"E734A671-69AE-4080-AE5E-121616E34742"];
            self.ad = [[BeaconAdvertisementData alloc] initWithProximityUUID:uuid
                                                                        major:1111
                                                                        minor:[[CurrentUserHolder getToken] intValue]
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
