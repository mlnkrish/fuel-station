//
//  BeaconAdvertisementData.m
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "BeaconAdvertisementData.h"

@implementation BeaconAdvertisementData

- (id)initWithProximityUUID:(NSUUID *)proximityUUID major:(uint16_t)major minor:(uint16_t)minor measuredPower:(int8_t)power {
    self = [super init];
    
    if (self) {
        self.proximityUUID = proximityUUID;
        self.major = major;
        self.minor = minor;
        self.measuredPower = power;
    }
    
    return self;
}

- (NSDictionary *)beaconAdvertisement {
    NSString *beaconKey = @"kCBAdvDataAppleBeaconKey";
    
    unsigned char advertisementBytes[21] = {0};
    
    [self.proximityUUID getUUIDBytes:(unsigned char *)&advertisementBytes];
    
    advertisementBytes[16] = (unsigned char)(self.major >> 8);
    advertisementBytes[17] = (unsigned char)(self.major & 255);
    
    advertisementBytes[18] = (unsigned char)(self.minor >> 8);
    advertisementBytes[19] = (unsigned char)(self.minor & 255);
    
    advertisementBytes[20] = self.measuredPower;
    
    NSMutableData *advertisement = [NSMutableData dataWithBytes:advertisementBytes length:21];
    
    return [NSDictionary dictionaryWithObject:advertisement forKey:beaconKey];
}

@end
