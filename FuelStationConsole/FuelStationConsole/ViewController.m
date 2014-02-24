//
//  ViewController.m
//  FuelStationConsole
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "CurrentUserHolder.h"

@interface ViewController ()
@property BOOL checking;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[CurrentViewHolder set:self];
    self.checking = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(!self.checking) {
        self.checking = YES;
        if(beacon.proximity == CLProximityImmediate) {
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            NSNumber *userId = beacon.major;
            NSNumber *token = beacon.minor;
            NSLog(@"Userid:%@",[userId stringValue]);
            NSLog(@"Token:%@",[token stringValue]);
            NSString *url = [NSString stringWithFormat:@"http://fuel-station.herokuapp.com/users/%@",[userId stringValue]];

            [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"RESPONSE JSON: %@", responseObject);

                NSString *name = (NSString *) [responseObject objectForKey:@"name"];
                [CurrentUserHolder setName:name];
                [CurrentUserHolder setToken:[token stringValue]];

                UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"greet"];
                [[self navigationController] pushViewController:vc animated:YES];

            }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                self.checking = NO;
            }];
        } else {
         self.checking = NO;
        }
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [CurrentViewHolder set:self];
}
@end
