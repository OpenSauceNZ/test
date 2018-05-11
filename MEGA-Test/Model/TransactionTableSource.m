//
//  TransactionTableSource.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "TransactionTableSource.h"
#import "RecordViewCell.h"


@implementation TransactionTableSource

- (id)initDataSourceWithdArray:(RLMResults<Transaction *> *)array delegate:(id)delegate
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
    switch (self.sorttype)
    {
        case SortByAll:
            return 1;
            break;
        case SortByDay:
            return self.dayData.count;
            break;
        case SortByMonth:
            return self.monthData.count;
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (self.sorttype)
    {
        case SortByAll:
            return self.dataSourceArray.count;
            break;
        case SortByDay:
            return [(NSArray *)self.dayData[section][@"transactions"] count];
            break;
        case SortByMonth:
            return  [(NSArray *)self.monthData[section][@"transactions"] count];
            break;
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (self.sorttype > 0) ? 44:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.sorttype == SortByAll)
    {
        return nil;
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(14, 0, 100, 44)];
    [view addSubview:headerLabel];
    NSDictionary *dict;
    switch (self.sorttype)
    {
        case SortByDay:
            dict = self.dayData[section];
            headerLabel.text = dict[@"day"];
            break;
        case SortByMonth:
            dict = self.monthData[section];
            headerLabel.text = dict[@"month"];
            break;
        default:
            break;
    }
    return view;
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    RecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRecordDataCellId forIndexPath:indexPath];
    Transaction *eachTransaction;
    switch (self.sorttype)
    {
        case SortByAll:
            eachTransaction = self.dataSourceArray[indexPath.row];
            break;
        case SortByDay:
            eachTransaction = [(NSArray *)self.dayData[indexPath.section][@"transactions"] objectAtIndex:indexPath.row];
            break;
        case SortByMonth:
            eachTransaction = [(NSArray *)self.monthData[indexPath.section][@"transactions"] objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    cell.title.text = eachTransaction.name;
    NSDateFormatter *fm = [[NSDateFormatter alloc]init];
    [fm setDateFormat:@"yyy-MM-dd HH:mm"];
    cell.subTitle.text = [fm stringFromDate:eachTransaction.date];
    cell.amount.text = [NSString stringWithFormat:@"$%@", eachTransaction.displayAmount];
    cell.currency.text = @"NZD";//eachTransaction.currency.name;
    
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

- (NSArray *)monthData
{
    if (!_monthData)
    {
        NSMutableArray *holder = [NSMutableArray array];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM"];
        for (Transaction *each in self.dataSourceArray)
        {
            [holder addObject:[dateFormat stringFromDate:each.date]];
        }
        NSSet *set = [NSSet setWithArray:holder];
        NSMutableArray *finalTransaction = [NSMutableArray array];
        for (NSString *day in set)
        {
            NSMutableDictionary *transactions = [[NSMutableDictionary alloc]init];
            transactions[@"transactions"] = [NSMutableArray array];
            transactions[@"month"] = day;
            for (Transaction *each in self.dataSourceArray)
            {
                if ([day isEqualToString:[dateFormat stringFromDate:each.date]])
                {
                    [transactions[@"transactions"] addObject:each];
                }
            }
            [finalTransaction addObject:transactions];
        }
        _monthData = [finalTransaction copy];
    }
    return _monthData;
}


- (NSArray *)dayData
{
    if (!_dayData)
    {
        NSMutableArray *holder = [NSMutableArray array];
        NSDateFormatter *dateFormater = [[NSDateFormatter alloc]init];
        [dateFormater setDateFormat:@"yyy-MM-dd"];
        for (Transaction *each in self.dataSourceArray)
        {
            [holder addObject:[dateFormater stringFromDate:each.date]];
        }
        NSSet *set = [NSSet setWithArray:holder];
        NSMutableArray *transactions = [NSMutableArray array];
        for (NSString *day in set)
        {
            NSMutableDictionary *transactionHolder = [[NSMutableDictionary alloc]init];
            transactionHolder[@"transactions"] = [NSMutableArray array];
            transactionHolder[@"day"] = day;
            for (Transaction *each in self.dataSourceArray)
            {
                if ([day isEqualToString:[dateFormater stringFromDate:each.date]])
                {
                    [transactionHolder[@"transactions"] addObject:each];
                }
            }
            [transactions addObject:transactionHolder];
        }
        _dayData = [transactions copy];
    }
    return _dayData;
}

@end
