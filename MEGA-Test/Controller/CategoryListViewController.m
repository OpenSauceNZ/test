//
//  CategoryListViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "CategoryListViewController.h"

@interface CategoryListViewController ()
@property (nonatomic) UITableView *tableView;
@end

@implementation CategoryListViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Test Code
    Category *category1 = [[Category alloc] init];
    category1.categoryId = [NSNumber numberWithInt:0];
    category1.name = @"Default";
    category1.budget = [NSNumber numberWithInt:50000];
    category1.color = [NSNumber numberWithInt:0];
    [self.realm beginWriteTransaction];
    [self.realm addOrUpdateObject:category1];
    [self.realm commitWriteTransaction];
    
    Category *category = [[Category alloc] init];
    category.categoryId = [NSNumber numberWithInt:1];
    category.name = @"Other";
    category.budget = [NSNumber numberWithInt:10000];
    category.color = [NSNumber numberWithInt:0];
    [self.realm beginWriteTransaction];
    [self.realm addOrUpdateObject:category];
    [self.realm commitWriteTransaction];
    // End
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Category";
    UIBarButtonItem *addTransactionButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addCategory)];
    self.tabBarController.navigationItem.leftBarButtonItem = addTransactionButton;
}

- (void)addCategory
{
    
}

@end
