//
//  ConnectAndParseAppDelegate.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConnectAndParseAppDelegate.h"
#import "ConnectAndParseViewController.h"
#import "ConnectAndParseTableViewController.h"
#import "Tweet.h"

@implementation ConnectAndParseAppDelegate

@synthesize window, viewController, tableViewController, myNavigationController, 
detailViewController, spinner;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{	
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loadingViewShower)
                                                 name:@"StartLoadingNotification"
                                               object:nil];	
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(loadingViewCloser)
                                                 name:@"CloseLoadingView"
                                               object:nil];	
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(presentOtherUsersTweets:)
                                                 name:@"PresentOtherUsersTweets"
                                               object:nil];		
    [detailViewController view];   
    [window makeKeyAndVisible];
	
	spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	spinner.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2-25, 
							   [[UIScreen mainScreen] bounds].size.height/2-25, 50.0f, 50.0f);
	[spinner setHidesWhenStopped:YES];
	
	[myNavigationController.view addSubview:spinner];
    [myNavigationController presentModalViewController:viewController animated:NO];
	
    return YES;
}

-(void)presentOtherUsersTweets:(id)otherName {    
	if (![[tableViewController getDisplayedUsersName] isEqual:[otherName object]]) {		
		[[NSNotificationCenter defaultCenter] postNotificationName:@"StartLoadingNotification" 
															object:nil];
		ConnectAndParseTableViewController *tabCont = [[ConnectAndParseTableViewController alloc] init];   
		tabCont.detailViewCalldelegate = self;	
		[myNavigationController pushViewController:tabCont animated:YES];
		[tabCont startingConnection:[otherName object]];
		[tabCont release]; 
	}   
}

-(void)loadingViewShower {	
	[spinner startAnimating];
}

-(void)loadingViewCloser {	
	[spinner stopAnimating];	
}

- (void)pushTableViewController { 
	[[NSNotificationCenter defaultCenter] postNotificationName:@"StartLoadingNotification" 
                                                        object:nil];
	[myNavigationController dismissModalViewControllerAnimated:YES];	
    [tableViewController startingConnection:viewController.txtField.text];	
}

-(void)dismissViewController {
    [myNavigationController dismissModalViewControllerAnimated:YES];
	[spinner stopAnimating];
}

-(void)pushDetailViewController:(Tweet *)tweet {    
    [detailViewController setContent:tweet];
    [myNavigationController pushViewController:detailViewController animated:YES];
    [spinner stopAnimating];
}

- (void)callSettings {	
	[myNavigationController presentModalViewController:viewController animated:YES];	
}

-(void)showSettingsAfterConnectionError {	
	[spinner stopAnimating];
	spinner.hidden = YES;	
}

@end
