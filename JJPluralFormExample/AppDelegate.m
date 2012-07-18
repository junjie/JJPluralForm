//
//  AppDelegate.m
//  JJPluralFormExample
//
//  Created by Lin Junjie (Clean Shaven Apps Pte. Ltd.) on 18/7/12.
//  Copyright (c) 2012 Lin Junjie. All rights reserved.
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
	self.viewController = [[LocalizationViewController alloc] initWithStyle:UITableViewStylePlain];
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
