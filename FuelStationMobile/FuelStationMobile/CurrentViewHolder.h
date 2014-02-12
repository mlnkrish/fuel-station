//
//  CurrentViewHolder.h
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BeaconAwareViewController.h"

@interface CurrentViewHolder : NSObject


+ (BeaconAwareViewController *) get;
+ (void) set:(BeaconAwareViewController *)view;

@end
