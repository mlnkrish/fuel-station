//
//  ViewController.m
//  FuelStationMobile
//
//  Created by MLN on 10/02/14.
//  Copyright (c) 2014 ThoughtWorks. All rights reserved.
//

#import "ViewController.h"
#import "CurrentUserHolder.h"



@interface ViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *pickerViewDataSource;
    UIPickerView *myPickerView;
    UIView *bckgPickerView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bckgPickerView=[[UIView alloc]initWithFrame:CGRectMake(60, self.view.frame.size.height-200, 200, 300)];
    bckgPickerView.alpha=0.9f;
    bckgPickerView.backgroundColor=[UIColor whiteColor];
    myPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 300)];
    [bckgPickerView addSubview:myPickerView];
    
    myPickerView.delegate=self;
    myPickerView.dataSource=self;
    pickerViewDataSource=[[NSMutableArray alloc]init];
    for(NSUInteger i=1;i<50;i++)
    {
        [pickerViewDataSource addObject:[NSString stringWithFormat:@"%lu",(unsigned long)i]];
    }
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(numberOfLitresLableTapped)];
    [self.numberOfLitresLabel addGestureRecognizer:gesture];
    
    [self.numberOfLitresLabel setUserInteractionEnabled:YES];


}


-(void)numberOfLitresLableTapped{
    
        [self.view addSubview:bckgPickerView];
    [self.bckgScrollView setContentOffset:CGPointMake(0, 100) animated:YES];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 37)];
    label.text = [pickerViewDataSource objectAtIndex:row];
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0f]];
    label.textColor=[UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    // [label autorelease];
    return label;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Total rows in our component.
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerViewDataSource count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *title;
    title=[pickerViewDataSource objectAtIndex:row];
    return title;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.numberOfLitresLabel setText:[pickerViewDataSource objectAtIndex:row]];
    [bckgPickerView removeFromSuperview];
      [self.bckgScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}



- (void) beaconDetected:(CLBeacon *)beacon {

    if(beacon.proximity == CLProximityNear || beacon.proximity == CLProximityImmediate) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"fillup"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}



- (void) viewDidAppear:(BOOL)animated {
    [CurrentViewHolder set:self];
}

@end
