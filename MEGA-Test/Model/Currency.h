//
//  currency.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <Realm/Realm.h>

@interface Currency : RLMObject
@property NSNumber<RLMInt> *currencyId;
@property NSString *name;
@property (readonly) RLMLinkingObjects *owners;
@end
