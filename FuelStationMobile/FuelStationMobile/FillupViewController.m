//
//  FillupViewController.m
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "FillupViewController.h"

@interface FillupViewController ()

@end

@implementation FillupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CurrentViewHolder set:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconDetected:(CLBeacon *)beacon {    
    NSLog(@"I got called - %@", beacon);
}

- (void) beaconLost {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
