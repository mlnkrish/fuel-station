//
//  FillupViewController.m
//  FuelStationConsole
//
//  Created by MLN on 14/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "FillupViewController.h"
#import "AFHTTPRequestOperation.h"
#import "CurrentUserHolder.h"
#import "AFHTTPRequestOperationManager.h"
#import "CurrentViewHolder.h"

@interface FillupViewController ()
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
                                                 selector:@selector(checkForPaymentMade)
                                                 userInfo:nil
                                                  repeats:YES];

}

- (void)checkForPaymentMade {
    if(!self.checking) {
        self.checking = YES;
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSString *token = [CurrentUserHolder getToken];
        NSString *url = [NSString stringWithFormat:@"http://fuel-station.herokuapp.com/payments/%@",token];

        [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"RESPONSE JSON: %@", responseObject);
            if([[responseObject objectForKey:@"paid"] boolValue]) {
                [self.timer invalidate];
                UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"thanks"];
                [[self navigationController] pushViewController:vc animated:YES];
            } else {
                self.checking = NO;
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            self.checking = NO;
        }];


    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) beaconLost {
    [[[CurrentViewHolder get] navigationController] popToRootViewControllerAnimated:false];
}

@end
