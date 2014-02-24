//
//  FillupViewController.m
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "FillupViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "CurrentUserHolder.h"

@interface FillupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *quantity;
@property NSTimer *timer;
@property BOOL checking;
@end

@implementation FillupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CurrentViewHolder set:self];
    self.checking = NO;
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0
                                                   target:self
                                                 selector:@selector(checkForFuelFilled)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)checkForFuelFilled {
    if(!self.checking)
    {
        self.checking = YES;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *token = [CurrentUserHolder getToken];
        NSString *url = [NSString stringWithFormat:@"http://fuel-station.herokuapp.com/topups/%@",token];
        NSLog(@"URL: %@",url);
        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RESPONSE JSON: %@", responseObject);
            if([[responseObject objectForKey:@"valid"] boolValue]) {
                [self.timer invalidate];
                NSString *value = (NSString *) [responseObject objectForKey:@"val"];
                [CurrentUserHolder setFuel:value];
                UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
                [[self navigationController] pushViewController:vc animated:YES];
            } else {
                self.checking = NO;
            }
        }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            self.checking = NO;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(!(beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate)) {
        NSLog(@"I got called - %@", beacon);
    }
}

- (void) beaconLost {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
