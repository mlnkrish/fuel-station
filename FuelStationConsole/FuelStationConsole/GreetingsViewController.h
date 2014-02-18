//
//  GreetingsViewController.h
//  FuelStationConsole
//
//  Created by MLN on 12/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeaconAwareViewController.h"
#import "CurrentViewHolder.h"
#import "CurrentUserHolder.h"

@interface GreetingsViewController : BeaconAwareViewController
@property (weak, nonatomic) IBOutlet UILabel *Greeting;

@end
