//
//  ViewController.h
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CurrentViewHolder.h"
#import "BeaconAwareViewController.h"

@interface ViewController : BeaconAwareViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *status;

@end
