//
//  GreetingsViewController.m
//  FuelStationConsole
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "GreetingsViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"

@interface GreetingsViewController ()

@property NSTimer *timer;

@end

@implementation GreetingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [CurrentViewHolder set:self];
    self.Greeting.text = [NSString stringWithFormat:@"Hello, %@", [CurrentUserHolder getName]];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0
                                                   target:self
                                                 selector:@selector(checkForFuelSet)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(beacon.proximity == CLProximityImmediate) {
       NSLog(@"I got called - %@", beacon);
    } else {
        [self beaconLost];
    }
}

- (void) checkForFuelSet {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://10.4.33.53:3000/topups/%@",token];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RESPONSE JSON: %@", responseObject);

        if([[responseObject objectForKey:@"valid"]boolValue]) {
            [self.timer invalidate];
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fillup"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
    }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void) beaconLost {
    [self.timer invalidate];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
