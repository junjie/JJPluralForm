//
//  AppDelegate.m
//  JJPluralFormExample
//
//  Created by Lin Junjie on 18/7/12.
//  Copyright (c) 2012 Lin Junjie. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalizationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	self.viewController = [[LocalizationViewController alloc] initWithStyle:UITableViewStylePlain];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
