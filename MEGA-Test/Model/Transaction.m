//
//  Transaction.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "Transaction.h"
#import <Realm/Realm.h>

@implementation Transaction
+ (NSString *)primaryKey
{
    return @"transactionId";
}
@end
