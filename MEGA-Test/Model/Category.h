//
//  Category.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <Realm/Realm.h>


@interface Category : RLMObject
@property NSNumber<RLMInt> *categoryId;
@property NSString *name;
@property NSNumber<RLMInt> *budget;
@property NSNumber<RLMInt> *color;
@property (readonly) RLMLinkingObjects *owners;
@end

/*
 
 Color code:
    0 - Gary
    1 - Red
    2 - Blue
    3 - Yellow
    4 - Green
    5 - Cyan
 */
