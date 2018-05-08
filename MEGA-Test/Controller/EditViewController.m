//
//  EditViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "EditViewController.h"
#import "EditTableSource.h"
#import "EditViewCell.h"

@interface EditViewController () <EditTableDelgate>
@property (nonatomic, strong) EditTableSource *datasource;
@end

@implementation EditViewController

- (void)loadView
{
    [super loadView];
    self.title = @"Edit";
    UIBarButtonItem *trailButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    UIBarButtonItem *leadButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leadButton;
    self.navigationItem.rightBarButtonItem = trailButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.transaction)
    {
        Transaction *record = [[Transaction alloc] init];
        self.transaction = record;
    }
    [self.tableView registerClass:[EditViewCell class] forCellReuseIdentifier:kEditTableCellId];
    self.datasource = [[EditTableSource alloc]initDataSourceWithTransaction:self.transaction delegate:self];
    self.datasource.isAddNewRecord = self.isNewRecord;
    [self.tableView setDelegate:self.datasource];
    [self.tableView setDataSource:self.datasource];
    [self.tableView reloadData];
}

- (void)save
{
    NSMutableArray *content = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 6; i++)
    {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        EditViewCell *cell = [self.tableView cellForRowAtIndexPath:index];
        [content addObject:cell.contentField.text];
    }
    if (content.count > 0)
    {
        RLMResults *result = [Transaction allObjects];
        NSNumber *maxID = [NSNumber numberWithInt:(int)[result maxOfProperty:@"transactionId"]];
        
        self.transaction.transactionId = [NSNumber numberWithInt:[maxID intValue] + 1];
        self.transaction.name = content[0];
        self.transaction.amount = [NSNumber numberWithInt:[content[1] intValue]];
        if ([content[2] intValue] < 2)
        {
            self.transaction.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:[content[2] intValue]]];
        }
        else
        {
            assert(false);
        }

        self.transaction.category = [Category objectForPrimaryKey:[NSNumber numberWithInt:0]];
        self.transaction.date = [[NSDate alloc] init];
        self.transaction.note = content[5];
        
        Category *category = [Category objectForPrimaryKey:[NSNumber numberWithInt:0]];
        
        BOOL isVaildTransaction = ([category.budget intValue] - [content[1] intValue]) > 0;
        
        if (isVaildTransaction)
        {
            [[RLMRealm defaultRealm] beginWriteTransaction];
            category.budget = [NSNumber numberWithInt:[category.budget intValue] - [content[1] intValue]];
            [[RLMRealm defaultRealm] addOrUpdateObject:category];
            [[RLMRealm defaultRealm] addObject:self.transaction];
            [[RLMRealm defaultRealm] commitWriteTransaction];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self alertError:@"Error" message:@"Beyound the category budget"];
        }
    }
    
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertError:(NSString *)title message:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Back" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
