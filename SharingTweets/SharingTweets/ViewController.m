//
//  ViewController.m
//  SharingTweets
//
//  Created by Yuge Xiong on 11/2/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
#import "Social/Social.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *TweetEditingSpace;
- (void)configureTextView;
@property (weak, nonatomic) IBOutlet UIToolbar *actionButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureTextView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addButton:(id)sender {
    if ([self.TweetEditingSpace isFirstResponder]){
        [self.TweetEditingSpace resignFirstResponder];
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: @"Upload" message:@"Share what's on your mind now!" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle: @"Cancel" style: UIAlertActionStyleDefault handler:nil];
    UIAlertAction *tweetAlert = [UIAlertAction actionWithTitle: @"Share" style: UIAlertActionStyleDefault handler:
                                 ^(UIAlertAction *action){
                                     UIActivityViewController *activity = [[UIActivityViewController alloc] initWithActivityItems:@[self.TweetEditingSpace.text] applicationActivities:nil];
                                     [self presentViewController:activity animated:YES completion:nil];
                                 }];
    [alertController addAction:cancelAlert];
    [alertController addAction:tweetAlert];
    [self presentViewController: alertController animated: YES completion: nil];
}

- (void)configureTextView {
    self.TweetEditingSpace.layer.backgroundColor = [UIColor colorWithRed:1 green:230/255 blue:192/255 alpha:0.02].CGColor;
    self.TweetEditingSpace.layer.borderWidth = 2.0;
    self.TweetEditingSpace.layer.borderColor = [UIColor colorWithRed:1 green:0.9 blue:0.75 alpha:1].CGColor;
    //self.TweetEditingSpace.layer.cornerRadius = 10.0;
    
}
@end
