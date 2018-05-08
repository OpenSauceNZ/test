//
//  EditTableSource.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 8/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "Transaction.h"

#define kEditTableCellId @"EditTableCell"

@protocol EditTableDelgate <NSObject>
@optional
- (void)loadDetailsAtIndexPath:(NSIndexPath *)index;
@end

@interface EditTableSource : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) int sectionOneRows;
@property (nonatomic, assign) id<EditTableDelgate> delegate;
@property (nonatomic, strong) Transaction *transaction;
@property (nonatomic) BOOL isAddNewRecord;

- (id)initDataSourceWithTransaction:(Transaction *)trasaction delegate:(id)delegate;

@end
