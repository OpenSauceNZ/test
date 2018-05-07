//
//  currency.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "Currency.h"
#import "Transaction.h"

@implementation Currency
+ (NSString *)primaryKey
{
    return @"currencyId";
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"owners": [RLMPropertyDescriptor descriptorWithClass:Transaction.class propertyName:@"currency"],
             };
}

@end
