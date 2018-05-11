//
//  BaseTableViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 11/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "BaseTableViewController.h"


@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)alertError:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)fetchJSON
{
    NSURL *apiUrl = [NSURL URLWithString:@"http://www.apilayer.net/api/live?access_key=6ff41f88cf4fa7445a530aa0cb890346&format=1"];
    [[NSURLSession.sharedSession dataTaskWithURL:apiUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finished fetching courses....");
        NSError *err;
        NSDictionary *courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        if (err)
        {
            NSLog(@"Failed to serialize into JSON: %@", err);
            return;
        }
        Exchange *exchange = Exchange.new;
        exchange.quotes = courseJSON[@"quotes"];
        exchange.nzdRate = [NSNumber numberWithFloat:[exchange.quotes[@"USDNZD"] floatValue]];
        self.exchange = exchange;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }] resume];
}

@end
