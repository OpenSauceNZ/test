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
#import "EditViewCell.h"
#import "CategoryPickerViewController.h"

//typedef void(^PickerCallback)(NSInteger row, NSInteger component);
typedef void(^CategoryCallback)(EditViewCell *cell);

@protocol EditTableDelgate <NSObject>
@optional
- (void)loadDetailsAtIndexPath:(NSIndexPath *)index;
@end

@interface EditTableSource : NSObject <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) int sectionOneRows;
@property (nonatomic, assign) id<EditTableDelgate> delegate;
@property (nonatomic, strong) Transaction *transaction;
@property (nonatomic) BOOL isAddNewRecord;

@property (nonatomic, copy) CategoryCallback callback;
@property (nonatomic, strong) Category *seletedCategory;
@property (nonatomic, strong) Currency *selectCurrency;

- (id)initDataSourceWithTransaction:(Transaction *)trasaction delegate:(id)delegate;

@end
