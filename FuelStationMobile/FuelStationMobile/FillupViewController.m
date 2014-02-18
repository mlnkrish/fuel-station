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
@end

@implementation FillupViewController

- (IBAction)onFill:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"topup": self.quantity.text, @"token":[CurrentUserHolder getToken]};
    [manager POST:@"http://localhost:3000/users/2046/topups" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RESPONSE JSON: %@", responseObject);
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0
                                                       target:self
                                                     selector:@selector(checkForFuelFilled)
                                                     userInfo:nil
                                                      repeats:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
   }

- (void)checkForFuelFilled {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://localhost:3000/topups/%@",token];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RESPONSE JSON: %@", responseObject);

        if([[responseObject objectForKey:@"valid"] boolValue] && [[responseObject objectForKey:@"done"] boolValue]) {

            [self.timer invalidate];
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"payment"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
    }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CurrentViewHolder set:self];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
