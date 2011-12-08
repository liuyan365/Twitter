//
//  main.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ConnectAndParseAppDelegate.h"

int main(int argc, char *argv[])
{
    //@autoreleasepool
	//{
    //    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
	
    //}
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([ConnectAndParseAppDelegate class]));
    [pool release];
    return retVal;
}

