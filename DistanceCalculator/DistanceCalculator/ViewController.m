//
//  ViewController.m
//  DistanceCalculator
//
//  Created by Yuge Xiong on 10/31/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()
@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *dest1;
@property (weak, nonatomic) IBOutlet UITextField *dest2;
@property (weak, nonatomic) IBOutlet UITextField *dest3;
@property (weak, nonatomic) IBOutlet UILabel *dist1;
@property (weak, nonatomic) IBOutlet UILabel *dist2;
@property (weak, nonatomic) IBOutlet UILabel *dist3;
@property (weak, nonatomic) IBOutlet UIButton *trigger;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSwitch;

@end

@implementation ViewController

- (IBAction)triggerButton:(id)sender {
    self.trigger.enabled = NO;
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.startLocation.text;
    NSString *end1 = self.dest1.text;
    NSString *end2 = self.dest2.text;
    NSString *end3 = self.dest3.text;
    NSArray *dests = @[end1, end2, end3];
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;

    if (self.unitSwitch.selectedSegmentIndex == 0){
        self.req.callback = ^void(NSArray *response){
            ViewController *strongSelf = weakSelf;
            if (!strongSelf) return;
            
            NSNull *badResult = [NSNull null];
            if (response[0] != badResult){
                double num1 = ([response[0] floatValue] / 1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num1];
                strongSelf.dist1.text = x;
            }else {
                strongSelf.dist1.text = @"Error!";
            }
            if (response[1] != badResult){
                double num2 = ([response[1] floatValue] / 1000.0);
                NSString *y = [NSString stringWithFormat:@"%.2f km", num2];
                strongSelf.dist2.text = y;
            }else {
                strongSelf.dist2.text = @"Error!";
            }
            if (response[2] != badResult){
                double num3 = ([response[2] floatValue] / 1000.0);
                NSString *z = [NSString stringWithFormat:@"%.2f km", num3];
                strongSelf.dist3.text = z;
            }else {
                strongSelf.dist3.text = @"Error!";
            }
            strongSelf.trigger.enabled = YES;
            strongSelf.req = nil;
        };
    }else if(self.unitSwitch.selectedSegmentIndex == 1){
        self.req.callback = ^void(NSArray *response){
            ViewController *strongSelf = weakSelf;
            if (!strongSelf) return;
            
            NSNull *badResult = [NSNull null];
            if (response[0] != badResult){
                double num1 = ([response[0] floatValue] / 1609.344);
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num1];
                strongSelf.dist1.text = x;
            }else {
                strongSelf.dist1.text = @"Error!";
            }
            if (response[1] != badResult){
                double num2 = ([response[1] floatValue] / 1609.344);
                NSString *y = [NSString stringWithFormat:@"%.2f miles", num2];
                strongSelf.dist2.text = y;
            }else {
                strongSelf.dist2.text = @"Error!";
            }
            if (response[2] != badResult){
                double num3 = ([response[2] floatValue] / 1609.344);
                NSString *z = [NSString stringWithFormat:@"%.2f miles", num3];
                strongSelf.dist3.text = z;
            }else {
                strongSelf.dist3.text = @"Error!";
            }
            strongSelf.trigger.enabled = YES;
            strongSelf.req = nil;
        };
    }else{
        self.req.callback = ^void(NSArray *response){
            ViewController *strongSelf = weakSelf;
            if (!strongSelf) return;
            
            NSNull *badResult = [NSNull null];
            if (response[0] != badResult){
                double num1 = [response[0] floatValue];
                NSString *x = [NSString stringWithFormat:@"%.2f m", num1];
                strongSelf.dist1.text = x;
            }else {
                strongSelf.dist1.text = @"Error!";
            }
            if (response[1] != badResult){
                double num2 = [response[1] floatValue];
                NSString *y = [NSString stringWithFormat:@"%.2f m", num2];
                strongSelf.dist2.text = y;
            }else {
                strongSelf.dist2.text = @"Error!";
            }
            if (response[2] != badResult){
                double num3 = [response[2] floatValue];
                NSString *z = [NSString stringWithFormat:@"%.2f m", num3];
                strongSelf.dist3.text = z;
            }else {
                strongSelf.dist3.text = @"Error!";
            }
            strongSelf.trigger.enabled = YES;
            strongSelf.req = nil;
        };
    }
    
    [self.req start];
}
@end
