//
//  ViewController.m
//  Conversion
//
//  Created by Yuge Xiong on 10/30/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
int convertDayToHour (int userInput){
    int hour = userInput*24;
    return hour;
}
int convertDayToMinute (int userInput){
    int minute = userInput*24*60;
    return minute;
}
int convertDayToSecond (int userInput){
    int second = userInput*24*60*60;
    return second;
}
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputUnit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *switchUnit;
@property (weak, nonatomic) IBOutlet UILabel *outputUnit;

@end

@implementation ViewController

- (IBAction)updateButton:(id)sender {
    
    NSMutableString *buf = [NSMutableString new];
    int userInput = [self.inputUnit.text intValue];
    
    if (self.switchUnit.selectedSegmentIndex == 0){
        int hr = convertDayToHour(userInput);
        [buf appendString: [@(hr) stringValue]];
    }else if (self.switchUnit.selectedSegmentIndex == 1){
        int min = convertDayToMinute(userInput);
        [buf appendString: [@(min) stringValue]];
    }else{
        int sec = convertDayToSecond(userInput);
        [buf appendString: [@(sec) stringValue]];
    }
    
    self.outputUnit.text = buf;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
