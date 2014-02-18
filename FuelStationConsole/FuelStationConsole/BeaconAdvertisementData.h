//
//  BeaconAdvertisementData.h
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconAdvertisementData : NSObject
@property (strong,nonatomic) NSUUID *proximityUUID;
@property (assign,nonatomic) uint16_t major;
@property (assign,nonatomic) uint16_t minor;
@property (assign,nonatomic) int8_t measuredPower;

- (id)initWithProximityUUID:(NSUUID *)proximityUUID
                      major:(uint16_t)major
                      minor:(uint16_t)minor
              measuredPower:(int8_t)power;


- (NSDictionary *)beaconAdvertisement;

@end
