//
//  BaseViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "BaseViewController.h"
#import "EditViewController.h"


@interface BaseViewController ()
@end

@implementation BaseViewController

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];

    UIBarButtonItem *addTransactionButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addTransaction)];
    self.tabBarController.navigationItem.leftBarButtonItem = addTransactionButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.realm = [RLMRealm defaultRealm];
    NSLog(@"Realm Path: %@",[RLMRealmConfiguration defaultConfiguration].fileURL);
}

- (void)addTransaction
{
    EditViewController *vc = [[EditViewController alloc] init];
    vc.isNewRecord = YES;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    nav.modalPresentationStyle = UIModalPresentationFormSheet;
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    nav.preferredContentSize = CGSizeMake(350, 380);
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.tabBarController.navigationItem.title = title;
}

- (void)alertError:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
