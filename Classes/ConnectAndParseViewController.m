//
//  ConnectAndParseViewController.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConnectAndParseViewController.h"

#import "Parser.h"
#import "Tweet.h"
#import "Reachability.h"

@implementation ConnectAndParseViewController

@synthesize txtField, delegate, goButton, backButton, doneButton, buttonBar;

- (IBAction)startConnection {	
	if ([txtField.text length] == 0) {		
		UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Alert" 
															  message:@"Textfield is empty! Enter Your name!" 
															 delegate:self 
													cancelButtonTitle:@"Ok" 
													otherButtonTitles:nil];
		[txtField resignFirstResponder];
        [simpleAlert show];
        [simpleAlert release];
	} else {        
        Reachability *reachabilityChecker = [Reachability reachabilityWithHostName:@"www.google.com"];        
        NetworkStatus internetStatus = [reachabilityChecker currentReachabilityStatus];
        if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {            
            UIAlertView *myAlert = [[UIAlertView alloc]
                                    initWithTitle:@"No Internet Connection"   
									message:@"You require an internet connection via WiFi or cellular network for location finding to work."
                                    delegate:self
                                    cancelButtonTitle:@"Ok"
                                    otherButtonTitles:nil];
            [myAlert show];
            [myAlert release];            
        } else { 
            [delegate pushTableViewController];	
            [txtField resignFirstResponder];
		}	
	}
}

-(IBAction)hide{
    [delegate dismissViewController];
}

-(IBAction) hideKeyBoard{
	[txtField resignFirstResponder];	
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{	
    [self shouldAutorotateToInterfaceOrientation:NO];
	[buttonBar setHidden:YES];
    [super viewDidLoad];	
}

- (void)viewDidDisappear:(BOOL)animated
{
	[goButton setHidden:YES];
	[buttonBar setHidden:NO];	
	[super viewDidDisappear:animated];
}

@end
