//
//  TransactionTableSource.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Transaction.h"

#define kRecordDataCellId @"RecordDataCell"

typedef NS_ENUM(NSInteger, SortType)
{
    SortByAll = 0,
    SortByDay,
    SortByMonth
};

@protocol  TransactionTableDelgate <NSObject>
@optional
- (void)loadDetailsAtIndexPath:(NSIndexPath *)index;
@end

@interface TransactionTableSource: NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int sectionOneRows;
@property (nonatomic, assign) id<TransactionTableDelgate> delegate;
@property (nonatomic, strong) RLMResults<Transaction *> *dataSourceArray;
@property (nonatomic, strong) RLMResults<Category *> *categorySourceArray;
@property (nonatomic, assign) SortType sorttype;
@property (nonatomic, strong) NSArray *dayData;
@property (nonatomic, strong) NSArray *monthData;

- (id)initDataSourceWithdArray:(RLMResults<Transaction *>*)array delegate:(id)delegate;

@end
