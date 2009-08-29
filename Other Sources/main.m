//
//  main.m
//  MyShooting
//
//  Created by 小野 将司 on 09/08/24.
//  Copyright レッドフォックス株式会社 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	int retVal = UIApplicationMain(argc, argv, nil, @"MyShootingAppDelegate");
    [pool release];
    return retVal;
}
