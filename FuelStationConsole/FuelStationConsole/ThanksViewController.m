//
//  ThanksViewController.m
//  FuelStationConsole
//
//  Created by MLN on 24/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "ThanksViewController.h"
#import "CurrentViewHolder.h"

@interface ThanksViewController ()

@end

@implementation ThanksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void) beaconLost {
    [[[CurrentViewHolder get] navigationController] popToRootViewControllerAnimated:false];
}

@end
