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
#define kRecordDataCellId @"RecordDataCell"

@interface TransactionViewController () <TransactionTableDelgate>
@property (nonatomic) UITableView *tableView;
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
    
    TransactionTableSource *datasource = [[TransactionTableSource alloc]initDataSourceWithdArray:@[@"hahah"] delegate:self];
    self.tableView.delegate = datasource;
    self.tableView.dataSource = datasource;
    [self.tableView reloadData];
    
//    [self.realm beginWriteTransaction];
//    Currency *c = [[Currency alloc] init];
//    c.name = @"NZD";
//    c.currencyId = [NSNumber numberWithInt:0];
//    [self.realm addOrUpdateObject:c];
//
//
//    Transaction *record = [[Transaction alloc] init];
//    record.transactionId = [NSNumber numberWithInt:50];
//    record.name = @"test";
//    record.date = [[NSDate alloc] init];
//    record.note = @"testtest";
//    record.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:0]];
//    RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Default'"];
//    record.category = categories[0];
//    [self.realm addOrUpdateObject:record];
//
//    Transaction *record1 = [[Transaction alloc] init];
//    {
//        record1.transactionId = [NSNumber numberWithInt:60];
//        record1.name = @"test";
//        record1.date = [[NSDate alloc] init];
//        record1.note = @"testtest";
//        record1.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:0]];
//        RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Default'"];
//        record1.category = categories[0];
//    }
//
//    [self.realm addOrUpdateObject:record1];
//
//    Transaction *record2 = [[Transaction alloc] init];
//    {
//        [self.realm addObject:c];
//        record2.transactionId = [NSNumber numberWithInt:70];
//        record2.name = @"test";
//        record2.date = [[NSDate alloc] init];
//        record2.note = @"testtest";
//        record2.currency = [Currency objectForPrimaryKey:[NSNumber numberWithInt:0]];
//        RLMResults<Category *> *categories = [Category objectsWhere:@"name = 'Default'"];
//        record2.category = categories[0];
//    }
//
//    [self.realm addOrUpdateObject:record2];
//
//    [self.realm commitWriteTransaction];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Transaction";
}

@end
