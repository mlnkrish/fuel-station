//
//  ViewController.m
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.status.text = @"Hellos";
    [CurrentViewHolder set:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
