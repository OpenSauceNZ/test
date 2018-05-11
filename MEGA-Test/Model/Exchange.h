//
//  Exchange.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 11/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exchange : NSObject
@property (nonatomic, strong) NSDictionary *quotes;
@property (nonatomic, strong) NSNumber *nzdRate;
@end
