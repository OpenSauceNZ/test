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
    self.tabBarController.navigationItem.rightBarButtonItem = addTransactionButton;
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
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    vc.preferredContentSize = CGSizeMake(350, 380);
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    self.tabBarController.navigationItem.title = title;
}
@end
