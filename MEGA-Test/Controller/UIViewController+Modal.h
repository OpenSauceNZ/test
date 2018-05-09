//
//  UIViewController+Modal.h
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Modal)
- (void)presentTransparentController:(UIViewController *)controller animated:(BOOL)animated;
@end
