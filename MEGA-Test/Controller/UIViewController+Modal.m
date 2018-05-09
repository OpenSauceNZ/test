//
//  UIViewController+Modal.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "UIViewController+Modal.h"

@implementation UIViewController (Modal)
- (void)presentTransparentController:(UIViewController *)controller animated:(BOOL)animated
{
    controller.view.backgroundColor = [UIColor clearColor];
    controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:controller animated:animated completion:^(void) {
        controller.view.superview.backgroundColor = [UIColor clearColor];
    }];
}
@end
