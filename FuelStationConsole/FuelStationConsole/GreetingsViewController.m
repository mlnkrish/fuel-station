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
@property (weak, nonatomic) IBOutlet UILabel *greetText;
@property (weak, nonatomic) IBOutlet UITextField *fillValue;
@end

@implementation GreetingsViewController

- (IBAction)doFillup:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://fuel-station.herokuapp.com/topups/%@",token];
    NSDictionary *parameters = @{@"topup": self.fillValue.text, @"token":[CurrentUserHolder getToken]};

    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fillup"];
        [[self navigationController] pushViewController:vc animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CurrentViewHolder set:self];
    self.greetText.text = [NSString stringWithFormat:@"Welcome %@", [CurrentUserHolder getName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) beaconDetected:(CLBeacon *)beacon {
    if(beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
//       NSLog(@"I got called - %@", beacon);
    } else {
        [self beaconLost];
    }
}

- (void) beaconLost {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
