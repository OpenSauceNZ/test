//
//  Category.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "Category.h"
#import "Transaction.h"

@implementation Category
+ (NSString *)primaryKey
{
    return @"categoryId";
}

+ (NSDictionary *)linkingObjectsProperties {
    return @{
             @"owners": [RLMPropertyDescriptor descriptorWithClass:Transaction.class propertyName:@"category"],
             };
}
@end
