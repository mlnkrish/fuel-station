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
@property (weak, nonatomic) IBOutlet UILabel *display;

@end

@implementation PaymentViewController

- (IBAction)payNow:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *token = [CurrentUserHolder getToken];
    NSString *url = [NSString stringWithFormat:@"http://fuel-station.herokuapp.com/payments/%@",token];

    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"receipt"];
        [[self navigationController] pushViewController:vc animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
	[CurrentViewHolder set:self];
    NSString *fuel = [CurrentUserHolder getFuel];
    self.display.text = [NSString stringWithFormat:@"You have filled %@ ltrs of fuel",fuel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
