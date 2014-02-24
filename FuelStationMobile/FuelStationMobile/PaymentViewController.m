//
//  PaymentViewController.m
//  FuelStationMobile
//
//  Created by MLN on 11/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <AFNetworking/AFHTTPRequestOperation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "PaymentViewController.h"
#import "CurrentUserHolder.h"

@interface PaymentViewController ()

@end

@implementation PaymentViewController

- (IBAction)doPayNow:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://10.4.33.53:3000/payments/%@",token];
    
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"receipt"];
        [[self navigationController] pushViewController:vc animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


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

@end
