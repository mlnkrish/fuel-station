//
//  ViewController.m
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "ViewController.h"
#import "CurrentUserHolder.h"



@interface ViewController ()
{

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fillup"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [CurrentViewHolder set:self];
}

@end