//
//  ConnectAndParseViewController.h
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Downloader.h"
#import "Parser.h"
#import "Tweet.h"

@class Reachability;
@protocol TableViewCallingDelegate;

@interface ConnectAndParseViewController : UIViewController{

}
@property (nonatomic, retain) IBOutlet UITextField *txtField;
@property (nonatomic, retain) IBOutlet UIButton *goButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *backButton;
@property (nonatomic, retain) IBOutlet UINavigationBar *buttonBar;
@property (nonatomic, assign) IBOutlet id <TableViewCallingDelegate> delegate;

- (IBAction) startConnection;
- (IBAction) hide;
- (IBAction) hideKeyBoard;

@end

@protocol TableViewCallingDelegate
@optional
- (void)pushTableViewController;
- (void)dismissViewController;
@end

