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



@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(beacon.proximity == CLProximityImmediate) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSNumber *userId = beacon.major;
        NSNumber *token = beacon.minor;
        NSString *url = [NSString stringWithFormat:@"http://localhost:3000/users/%i",userId];
//        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"greet"];
//        [[self navigationController] pushViewController:vc animated:YES];


        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RESPONSE JSON: %@", responseObject);

            NSString *name = (NSString *) [responseObject objectForKey:@"name"];
            [CurrentUserHolder setName:name];
            [CurrentUserHolder setToken:token];

            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"greet"];
            [[self navigationController] pushViewController:vc animated:YES];

        }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [CurrentViewHolder set:self];
}
@end
