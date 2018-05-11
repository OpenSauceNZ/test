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

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = @"Transaction";
    UIBarButtonItem *order = [[UIBarButtonItem alloc] initWithTitle:@"Sort" style:UIBarButtonItemStylePlain target:self action:@selector(sort)];
    self.tabBarController.navigationItem.rightBarButtonItem = order;
    [self.tableView reloadData];
}

- (void)sort
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Transaction Record" message:@"Please choose the listing way of display transaction records" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"By Day" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.datasource.sorttype = SortByDay;
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"By Month" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.datasource.sorttype = SortByMonth;
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Show All" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.datasource.sorttype = SortByAll;
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
