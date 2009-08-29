//
//  MyShootingAppDelegate.m
//  MyShooting
//
//  Created by Masashi Ono on 09/08/24.
//  Copyright Masashi Ono 2009. All rights reserved.
//

#import "MyShootingAppDelegate.h"


@implementation MyShootingAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application
{    
	UIWindow* window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
	
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	[window setUserInteractionEnabled: YES];
	[window setMultipleTouchEnabled: YES];

    // Set orientation of device to landscape (change if you don't want)
	[[Director sharedDirector ] setDeviceOrientation:CCDeviceOrientationPortrait];
	[[Director sharedDirector ] attachInWindow:window];
	
	[window makeKeyAndVisible];
	
    //----------------------------------------
    // Boot your own game here
    //----------------------------------------
	MainScene *scene = [MainScene node];
	[[Director sharedDirector] runWithScene:scene];
}

@end
