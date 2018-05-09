//
//  EditTableSource.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 8/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "EditTableSource.h"
#import "EditViewCell.h"

@implementation EditTableSource
{
    NSArray *titles;
    NSArray *contents;
}

- (id)initDataSourceWithTransaction:(Transaction *)transaction delegate:(id)delegate
{
    if (self = [super init])
    {
        self.transaction = transaction;
        self.delegate = delegate;
        titles = @[@"Name",@"Amount",@"Currency",@"Category",@"Date",@"Notes"];
        if (transaction.transactionId)
        {
            contents = @[transaction.name,transaction.amount,transaction.currency.name,transaction.category.name,transaction.date,transaction.note];
        }
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
    return titles.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    EditViewCell *cell = [[EditViewCell alloc] init];
    switch (indexPath.row)
    {
        case 1: // Amount
            cell = [tableView dequeueReusableCellWithIdentifier:kEditAmountCellId forIndexPath:indexPath];
            break;
        case 2: // Currency
            cell = [tableView dequeueReusableCellWithIdentifier:kEditSegmentTableCellId forIndexPath:indexPath];
            break;
        case 3:
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kEditCategoryCellId forIndexPath:indexPath];
                self.callback(cell);
            }
            break;
        case 4: // Date
            {
                cell = [tableView dequeueReusableCellWithIdentifier:kEditTableCellId forIndexPath:indexPath];
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyy-MM-dd HH:mm"];
                cell.contentField.userInteractionEnabled = NO;
                cell.contentField.text = [dateFormatter stringFromDate:[NSDate date]];
                cell.contentField.textColor = UIColor.lightGrayColor;
            }
            break;
        case 0: // Name
        case 5:
            cell = [tableView dequeueReusableCellWithIdentifier:kEditTableCellId forIndexPath:indexPath];
            cell.contentField.text = contents[indexPath.row] == nil ? @"": contents[indexPath.row];
            break;
    }
    cell.title.text = titles[indexPath.row];
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
