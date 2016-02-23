//
//  AppDelegate.m
//  PaginationCoreDataExample
//
//  Created by William Boles on 23/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

#import "AppDelegate.h"

#import <CoreDataServices/CDSServiceManager.h>

#import "PTEQuestionViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) UINavigationController *navigationController;

@property (nonatomic, strong) PTEQuestionViewController *viewController;

@end

@implementation AppDelegate

#pragma mark - ApplicationLifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[CDSServiceManager sharedInstance] setupModelURLWithModelName:@"Model"];
    
    /*-------------------*/
    
    self.window.backgroundColor = [UIColor clearColor];
    self.window.clipsToBounds = NO;
    
    [self.window makeKeyAndVisible];
    
    /*-------------------*/
    
    return YES;
}

#pragma mark - Window

- (UIWindow *)window
{
    if (!_window)
    {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.rootViewController = self.navigationController;
    }
    
    return _window;
}

#pragma mark - Navigation

- (UINavigationController *)navigationController
{
    if (!_navigationController)
    {
        _navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    }
    
    return _navigationController;
}

#pragma mark - ViewController

- (PTEQuestionViewController *)viewController
{
    if (!_viewController)
    {
        _viewController = [[PTEQuestionViewController alloc] init];
    }
    
    return _viewController;
}

@end
