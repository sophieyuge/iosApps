//
//  ViewController.m
//  CurrencyConversion
//
//  Created by Yuge Xiong on 10/31/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
#import "CurrencyRequest/CRCurrencyRequest.h"
#import "CurrencyRequest/CRCurrencyResults.h"

@interface ViewController () <CRCurrencyRequestDelegate>

@property (nonatomic) CRCurrencyRequest *req;
@property (weak, nonatomic) IBOutlet UITextField *inputNum;
@property (weak, nonatomic) IBOutlet UIButton *controlButton;
@property (weak, nonatomic) IBOutlet UILabel *eur;
@property (weak, nonatomic) IBOutlet UILabel *gbp;
@property (weak, nonatomic) IBOutlet UILabel *jpy;

@end

@implementation ViewController
- (IBAction)tappedButton:(id)sender {
    self.controlButton.enabled = NO;
    
    self.req = [[CRCurrencyRequest alloc] init];
    self.req.delegate = self;
    [self.req start];
}
- (void)currencyRequest:(CRCurrencyRequest *)req
    retrievedCurrencies:(CRCurrencyResults *)currencies{
    self.controlButton.enabled = YES;
    
    double inVal = [self.inputNum.text floatValue];
    double euroVal = inVal * currencies.EUR;
    double gbpVal = inVal * currencies.GBP;
    double jpyVal = inVal * currencies.JPY;
    NSString *tmp1 = [NSString stringWithFormat: @"%.2f", euroVal];
    NSString *tmp2 = [NSString stringWithFormat: @"%.2f", gbpVal];
    NSString *tmp3 = [NSString stringWithFormat: @"%.2f", jpyVal];
    self.eur.text = tmp1;
    self.gbp.text = tmp2;
    self.jpy.text = tmp3;
    
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
