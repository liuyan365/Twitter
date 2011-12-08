//
//  ConnectAndParseAppDelegate.h
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConnectAndParseViewController.h"
#import "ConnectAndParseTableViewController.h"
#import "ConnectAndParseDetailViewController.h"
#import "TwitterService.h"

@interface ConnectAndParseAppDelegate : UIResponder <UIApplicationDelegate, TableViewCallingDelegate, DetailViewCallingDelegate> {    		
	UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ConnectAndParseTableViewController *tableViewController;
@property (nonatomic, retain) IBOutlet ConnectAndParseViewController *viewController;
@property (nonatomic, retain) IBOutlet UINavigationController*  myNavigationController;
@property (nonatomic, retain) IBOutlet ConnectAndParseDetailViewController* detailViewController;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;

- (void) callSettings;

@end


