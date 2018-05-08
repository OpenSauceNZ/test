//
//  MonthTransectionViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "TransactionViewController.h"
#import "RecordViewCell.h"
#import "TransactionTableSource.h"

@interface TransactionViewController () <TransactionTableDelgate>
@property (nonatomic) UITableView *tableView;
@property (nonatomic,strong)TransactionTableSource *datasource;
@end

@implementation TransactionViewController

- (void)loadView
{
    [super loadView];

    UITableView *table = [[UITableView alloc] init];
    [self.view addSubview:table];
    table.keepVerticalInsets.equal = 0;
    table.keepHorizontalInsets.equal = 0;
    self.tableView = table;
}

- (void)loadDetailsAtIndexPath:(NSIndexPath *)index
{
    NSLog(@"%li",index.row);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[RecordViewCell class] forCellReuseIdentifier:kRecordDataCellId];
    
    RLMResults<Transaction *> *allTransaction = [Transaction allObjects];
    
    self.datasource = [[TransactionTableSource alloc]initDataSourceWithdArray:allTransaction delegate:self];
    self.datasource.categorySourceArray = nil;
    [self.tableView setDelegate:self.datasource];
    [self.tableView setDataSource:self.datasource];
    [self.tableView reloadData];
    
    // Test code
    [self.realm beginWriteTransaction];
    Currency *c = [[Currency alloc] init];
    c.name = @"USD";
    c.currencyId = [NSNumber numberWithInt:1];
    [self.realm addOrUpdateObject:c];

    Currency *cz = [[Currency alloc] init];
    cz.name = @"NZD";
    cz.currencyId = [NSNumber numberWithInt:0];
    [self.realm addOrUpdateObject:cz];

    Transaction *record = [[Transaction alloc] init];
    record.transactionId = [NSNumber numberWithInt:15];
    record.name = @"testOther1";
    record.date = [[NSDate alloc] init];
    record.note = @"testtest";
    record.amount = [NSNumber numberWithInt:50];
    record.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:1]];
    RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Other'"];
    record.category = categories[0];
    [self.realm addOrUpdateObject:record];

    Transaction *record1 = [[Transaction alloc] init];
    {
        record1.transactionId = [NSNumber numberWithInt:60];
        record1.name = @"test";
        record1.date = [[NSDate alloc] init];
        record1.note = @"testtest";
        record1.amount = [NSNumber numberWithInt:20];
        record1.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:0]];
        RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Default'"];
        record1.category = categories[0];
    }

    [self.realm addOrUpdateObject:record1];

    Transaction *record2 = [[Transaction alloc] init];
    {
        [self.realm addObject:c];
        record2.transactionId = [NSNumber numberWithInt:70];
        record2.name = @"test";
        record2.date = [[NSDate alloc] init];
        record2.note = @"testtest";
        record2.amount = [NSNumber numberWithInt:99];
        record2.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:0]];
        
        RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Default'"];
        Category *target = categories[0];
        target.budget = [NSNumber numberWithInt:target.budget.intValue - 99];
        [self.realm addOrUpdateObject:target];
        record2.category = target;
    }

    [self.realm addOrUpdateObject:record2];
    // End
    
    [self.realm commitWriteTransaction];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Transaction";
    UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
    self.tabBarController.navigationItem.rightBarButtonItem = order;
}

- (void)sort
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Transaction Record" message:@"Please choose the listing way of display transaction records" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"By Day" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"By Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Show All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
