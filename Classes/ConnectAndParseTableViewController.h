//
//  ConnectAndParseTableViewController.h
//  ConnectAndParse
//
//  Created by RealPoc on 26.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Downloader.h"
#import "Parser.h"
#import "Tweet.h"
#import "EGORefreshTableHeaderView.h"
#import "TwitterService.h"

@protocol DetailViewCallingDelegate;

typedef enum 
{
    startState,
    row    
} TableFillingPropersties;

@interface ConnectAndParseTableViewController : UITableViewController <UITableViewDelegate, EGORefreshTableHeaderDelegate>{
    
	NSMutableArray* tweetArray;    
    NSString *currentUserName;
    NSString *userName;  	
	EGORefreshTableHeaderView *refreshHeaderView;	
	BOOL reloading;    
    BOOL loading;
}

- (void)tableFiller:(NSMutableArray *)tweetsArray flag:(NSString *)fillingTypeFlag; 
- (void)currentTweetsBlockMaker;
- (void)startingConnection:(NSString *)name;
- (NSString *)getDisplayedUsersName;
- (IBAction)callSettingsViewController;

@property(nonatomic, retain)NSMutableArray* tweetArray;
@property(nonatomic, assign)IBOutlet id <DetailViewCallingDelegate> detailViewCalldelegate;

@end

@protocol DetailViewCallingDelegate
@optional
-(void)pushDetailViewController:(Tweet *)tweet;
-(void)callSettings;
@end

