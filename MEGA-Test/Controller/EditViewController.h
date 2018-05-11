//
//  EditViewController.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Transaction.h"
#import "BaseTableViewController.h"


typedef void(^CategoryDidSelectedCallback)(Category *selectedCategory);

@interface EditViewController : BaseTableViewController
@property (nonatomic) Transaction *transaction;
@property (nonatomic) BOOL isNewRecord;
@property (nonatomic, copy) CategoryDidSelectedCallback callback;
@end
