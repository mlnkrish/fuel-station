//
//  CurrentViewHolder.m
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "CurrentViewHolder.h"

@implementation CurrentViewHolder

static BeaconAwareViewController *current;

+ (BeaconAwareViewController *) get {
    return current;
}

+(void) set:(BeaconAwareViewController *)view {
    NSLog(@"Setting Current View - %@",[view class]);
    current = view;
}

@end
