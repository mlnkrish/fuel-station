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
#import "BeaconBroadcaster.h"

@interface ViewController : BeaconAwareViewController<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *numberOfLitresLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *bckgScrollView;

@end
