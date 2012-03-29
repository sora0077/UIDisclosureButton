//
//  AppDelegate.m
//  UIDisclosureButton
//
//  Created by t_hayashi on 12/03/29.
//  Copyright (c) 2012年 . All rights reserved.
//

#import "AppDelegate.h"
#import "UIDisclosureButton.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)dealloc
{
	[_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	
	
	UIDisclosureButton* button1 = [UIDisclosureButton buttonWithType:UIButtonTypeCustom];	// ignore buttonType
	button1.frame = CGRectMake(80, 100, 160, 30);	// ignore height
	[button1 setTitle:@"UIDiclosureButton" forState:UIControlStateNormal];
	[self.window addSubview:button1];
	
	UIDisclosureButton* button2 = [UIDisclosureButton buttonWithType:UIButtonTypeCustom];
	button2.frame = CGRectMake(80, 140, 160, 30);
	[button2 setTitle:@"UIDiclosureButton" forState:UIControlStateNormal];
	[button2 setHighlighted:YES];
	[self.window addSubview:button2];
	
	UIDisclosureButton* button3 = [UIDisclosureButton buttonWithType:UIButtonTypeCustom];
	button3.frame = CGRectMake(80, 180, 160, 30);
	[button3 setTitle:@"UIDiclosureButton" forState:UIControlStateNormal];
	[button3 setEnabled:NO];
	[self.window addSubview:button3];
	
	
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
