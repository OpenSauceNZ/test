//
//  BaseViewController.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

#import "Framework/KeepLayout/KeepLayout.h"
#import "Currency.h"
#import "Transaction.h"
#import "Category.h"

@interface BaseViewController : UIViewController
@property (nonatomic) RLMRealm *realm;
- (void)fetchJSON;
- (void)alertError:(NSString *)title message:(NSString *)message;
@end
