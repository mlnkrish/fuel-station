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

@interface FillupViewController ()
@property NSTimer *timer;
@end

@implementation FillupViewController

- (IBAction)doFillup:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://10.4.33.53:3000/topups/%@/done",token];

    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:2.0
                                                       target:self
                                                     selector:@selector(checkForPaymentMade)
                                                     userInfo:nil
                                                      repeats:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)checkForPaymentMade {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://10.4.33.53:3000/payments/%@",token];

    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"RESPONSE JSON: %@", responseObject);

        if([[responseObject objectForKey:@"paid"] boolValue]) {
            [self.timer invalidate];
            UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"thanks"];
            [[self navigationController] pushViewController:vc animated:YES];
        }
    }    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
