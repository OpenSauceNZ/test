//
//  CategoryListViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "CategoryListViewController.h"

@interface CategoryListViewController ()

@end

@implementation CategoryListViewController

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    Category *category = [[Category alloc] init];
    category.categoryId = [NSNumber numberWithInt:0];
    category.name = @"Default";
    category.color = [NSNumber numberWithInt:0];
    [self.realm beginWriteTransaction];
    [self.realm addOrUpdateObject:category];
    [self.realm commitWriteTransaction];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Category";
}

@end
