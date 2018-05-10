//
//  Transaction.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Category.h"
#import "Currency.h"

@interface Transaction : RLMObject

@property NSNumber<RLMInt> *transactionId;
@property NSString *name;
@property NSNumber<RLMInt> *amount;
@property NSNumber<RLMInt> *displayAmount;
@property NSDate *date;
@property NSString *note;
@property Currency *currency;
@property Category *category;

@end
