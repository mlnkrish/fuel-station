//
//  BeaconAwareViewController.m
//  FuelStationMobile
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "BeaconAwareViewController.h"

@interface BeaconAwareViewController ()

@end

@implementation BeaconAwareViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconDetected:(CLBeacon *)beacon {
    //Do nothing
}

-(void) beaconLost {
    
}

@end
