//
//  BaseTableViewController.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 11/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exchange.h"

@interface BaseTableViewController : UITableViewController
@property (nonatomic) Exchange *exchange;
- (void)fetchJSON;
- (void)alertError:(NSString *)title message:(NSString *)message;
@end
