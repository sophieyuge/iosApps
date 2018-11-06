//
//  ViewController.m
//  PushNotification
//
//  Created by Yuge Xiong on 11/6/18.
//  Copyright © 2018 Yuge Xiong. All rights reserved.
//

#import "ViewController.h"
#import "UserNotifications/UserNotifications.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *notificationButton;

@end

BOOL permissionGranted;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    permissionGranted = false;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        permissionGranted = granted;
    }];
    
}
- (IBAction)notification15secs:(id)sender {
    if (permissionGranted){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Hi there!";
        content.body = @"15 seconds have passed since you set the notification!";
        content.sound = [UNNotificationSound defaultSound];
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:15 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"localNotification" content:content trigger:trigger];
        [center addNotificationRequest:request withCompletionHandler:nil];
        
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Sorry" message:@"Please allow us to send notifications first" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler: nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}


@end
