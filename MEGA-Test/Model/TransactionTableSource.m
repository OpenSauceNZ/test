//
//  TransactionTableSource.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "TransactionTableSource.h"
#import "RecordViewCell.h"
#define kRecordDataCellId @"RecordDataCell"

@implementation TransactionTableSource

- (id)initDataSourceWithdArray:(NSArray *)array delegate:(id)delegate
{
    if (self = [super init])
    {
        self.dataSourceArray = array;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;//self.dataSourceArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecordDataCellId forIndexPath:indexPath];
    cell.textLabel.text = @"haha";
    return cell;
}
#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loadDetailsAtIndexPath:)])
    {
        [self.delegate loadDetailsAtIndexPath:indexPath];
    }
}

@end
