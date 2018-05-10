//
//  MainTabBarViewController.m
//  MEGA-Test
//
//  Created by Liguo Jiao on 7/05/18.
//  Copyright © 2018 Liguo Jiao. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "MainViewController.h"
#import "TransactionViewController.h"
#import "CategoryListViewController.h"

#include <vector>

struct tab_bar_view_controller_data
{
    UIViewController *controller;
    NSString *title;
    UIImage *image;
    UIImage *selectedImage;
};

@interface MainTabBarViewController () <UIGestureRecognizerDelegate, UITabBarControllerDelegate>

@end

@implementation MainTabBarViewController
{
    std::vector<tab_bar_view_controller_data> _tabs;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self initTabs];
}

- (void)initTabs
{
    if (_tabs.size() == 0)
    {
        _tabs = {
            {
                .controller = [[MainViewController alloc] init],
                .title = @"Graph",
                .image = nil,
                .selectedImage = nil,
            },
            {
                .controller = [[TransactionViewController alloc] init],
                .title = @"Transaction",
                .image = nil,
                .selectedImage = nil,
            },
            {
                .controller = [[CategoryListViewController alloc] init],
                .title = @"Category",
                .image = nil,
                .selectedImage = nil,
            },
        };
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    NSMutableArray <UIViewController *> *viewControllers = [[NSMutableArray alloc] initWithCapacity:_tabs.size()];
    
    for (auto &t : _tabs)
    {
        [viewControllers addObject:t.controller];
    }
    
    self.viewControllers = viewControllers;
    [self customizeTabBar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)customizeTabBar
{
    UITabBar *tabBar = self.tabBar;
    
    tabBar.tintColor = [UIColor cyanColor];
    
    int index = 0;
    for (UITabBarItem *item in tabBar.items)
    {
        item.image = _tabs[index].image;
        item.selectedImage = _tabs[index].selectedImage;
        item.title = _tabs[index].title;
        index++;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count > 1)
    {
        id topViewController = self.navigationController.topViewController;
        if ([topViewController respondsToSelector:@selector(swipeFromLeftEdgeEnabled)])
        {
            return [topViewController swipeFromLeftEdgeEnabled];
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return NO;
    }
}

- (BOOL)swipeFromLeftEdgeEnabled
{
    return NO;
}


@end
