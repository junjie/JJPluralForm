//
//  AppDelegate.m
//  JJPluralFormExample
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 22/2/14.
//  Copyright (c) 2014 Lin Junjie. All rights reserved.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "AppDelegate.h"
#import "LocalizationViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	self.viewController =
	[[LocalizationViewController alloc] initWithStyle:UITableViewStylePlain];
	
	UINavigationController *navigationController =
	[[UINavigationController alloc] initWithRootViewController:self.viewController];
	
	self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
