//
//  ViewController.m
//  instaGRAM
//
//  Created by Yuge Xiong on 11/2/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
#import "NXOAuth2.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *logout;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *refresh;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logout.enabled = false;
    self.refresh.enabled = false;
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)logoutTapped:(id)sender {
    NXOAuth2AccountStore *store = [NXOAuth2AccountStore sharedStore];
    NSArray *accounts = [store accountsWithAccountType:@"Instagram"];
    for (id acct in accounts)[store removeAccount:acct];
    self.login.enabled = true;
    self.logout.enabled = false;
    self.refresh.enabled = false;
}
- (IBAction)loginTapped:(id)sender {
    [[NXOAuth2AccountStore sharedStore] requestAccessToAccountWithType: @"Instagram"];
    self.login.enabled = false;
    self.logout.enabled = true;
    self.refresh.enabled = true;
}
- (IBAction)refreshTapped:(id)sender {
    NSArray *instagramAccounts = [[NXOAuth2AccountStore sharedStore] accountsWithAccountType:@"Instagram"];
    if ([instagramAccounts count] == 0){
        NSLog(@"Warning: %ld Instagram accounts logged in", (long)[instagramAccounts count]);
        return;
    }
    
    NXOAuth2Account *acct = instagramAccounts[0];
    NSString *token = acct.accessToken.accessToken;
    
    NSString *urlStr = [@"https://api.instagram.com/v1/users/self/media/recent/?access_token="stringByAppendingString:token];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data,NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error){
            NSLog(@"Error: Couldn't finish request: %@", error);
            return;
        }
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
        if (httpResp.statusCode <200 || httpResp.statusCode >=300){
            NSLog(@"Error: Got status code %ld", (long)httpResp.statusCode);
            return;
        }
        
        NSError *parseErr;
        id pkg = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseErr];
        if (!pkg){
            NSLog(@"Error: Couldn't parse response: %@", parseErr);
            return;
        }
        
        NSString *imageURLStr = pkg[@"data"][0][@"images"][@"standard_resolution"][@"url"];
        NSURL *imageURL = [NSURL URLWithString:imageURLStr];
        [[session dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error){
                NSLog(@"Error: Couldn't finish request: %@", error);
                return;
            }
            
            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse *)response;
            if (httpResp.statusCode <200 || httpResp.statusCode >=300){
                NSLog(@"Error: Got status code %ld", (long)httpResp.statusCode);
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{self.imageView.image = [UIImage imageWithData:data];
            });
            
        }]resume];
        
        
    }]resume];
    
}


@end
