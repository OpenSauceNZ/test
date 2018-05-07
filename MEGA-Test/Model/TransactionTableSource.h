//
//  TransactionTableSource.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol  TransactionTableDelgate<NSObject>
@optional
- (void)loadDetailsAtIndexPath:(NSIndexPath *)index;
@end

@interface TransactionTableSource:NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int sectionOneRows;
@property (nonatomic, assign) id<TransactionTableDelgate> delegate;
@property (nonatomic, strong) NSArray *dataSourceArray;

- (id)initDataSourceWithdArray:(NSArray *)array delegate:(id)delegate;
@end
