//
//  ConnectAndParseTableViewController.m
//  ConnectAndParse
//
//  Created by RealPoc on 26.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConnectAndParseTableViewController.h"
#import "Reachability.h"
#import "CustomCell.h"


@implementation ConnectAndParseTableViewController

@synthesize tweetArray, detailViewCalldelegate;

- (void)startingConnection:(NSString *)name {	
	currentUserName = [[NSString alloc] initWithString:name];
    [self currentTweetsBlockMaker];    
}

- (void)tableFiller:(NSMutableArray *)tweetsArray flag:(NSString *)fillingTypeFlag {    										
    int startState = 0;
    int startIndex = 0;
    if(fillingTypeFlag == @"old") {
        startState = [self.tweetArray count];        
    }   
    [self.tweetArray insertObjects:tweetsArray
                         atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(startState,[tweetsArray count])]];
    if(fillingTypeFlag == @"old") {
        startIndex = [self.tweetArray count]-[tweetsArray count];        
    }
    NSMutableArray *indexArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[tweetsArray count]; i++) {                                                                   
        [indexArray addObject:[NSIndexPath indexPathForRow:(startIndex+i) inSection:0]];                                                                   
    }                                                                        
    [[self tableView] insertRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationTop];  
    [indexArray release];    
}

- (void)currentTweetsBlockMaker {
    loading = YES;
    [[TwitterService sharedTwitterService] prepareForCurrentTweets:currentUserName 
                                                 tableLoadingBlock:^(NSMutableArray *tweetsArray){                                                     
                                                     if ([tweetsArray count] != 0) {                                                            
                                                         self.tweetArray=[NSMutableArray arrayWithArray:tweetsArray];                                                       
                                                         self.title = currentUserName;
                                                         [self.tableView reloadData];
                                                         userName = currentUserName;
                                                     }                                                     
                                                     [[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLoadingView" 
                                                                                                         object:nil];
                                                     [self performSelector:@selector(doneLoadingTableViewData) withObject:nil]; 
                                                     loading = NO;
                                                 }
     ];
}

- (NSString *)getDisplayedUsersName {
	return userName;
}

- (IBAction)callSettingsViewController {
	[detailViewCalldelegate callSettings];	
}

- (void)viewDidLoad {
    [super viewDidLoad];	
    if (refreshHeaderView == nil) {		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, 
																									  self.view.frame.size.width, 
																									  self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		refreshHeaderView = view;
		[view release];
	}
	[refreshHeaderView refreshLastUpdatedDate];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    
    if (tweetArray == nil)return 0;
    else return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {       
    if (tweetArray == nil)return 0;
    else return [tweetArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {  
    
    CustomCell *cell = [CustomCell createCell:tableView];    
    if (indexPath.row != [tweetArray count]) {
        [cell setCellContent:[tweetArray objectAtIndex:indexPath.row]];			
    } else {        
        cell = [[[UITableViewCell alloc] init] autorelease];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.text = @"Tap to load old tweets";       
    } 
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *)indexPath {	
	[detailViewCalldelegate pushDetailViewController:[tweetArray objectAtIndex:indexPath.row]];            
}	

- (void)reloadTableViewDataSource{
	reloading = YES;	
}

- (void)doneLoadingTableViewData{
	reloading = NO;
	[refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];	
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {		
	[refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {		
	[refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];		
}

#pragma mark - EGORefreshTableHeaderDelegate Methods
	
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{	
    [self reloadTableViewDataSource];    
	if ([tweetArray count]!=0) {
		[[TwitterService sharedTwitterService] prepareForNewTweets:userName 
                                                           tweetId:[[self.tweetArray objectAtIndex:0] tweetID]                                                 
                                                 tableLoadingBlock:^(NSMutableArray *tweetsArray) {                                                                    
                                                                    if ([tweetsArray count]!=0) {                                                                                                      
                                                                        [self tableFiller:tweetsArray flag:@"new"];                                                                                                                                                                                                                  
                                                                    }                                                                    
                                                                    [self doneLoadingTableViewData];                                                                    
                                                                } 
		 ];    
	} else [self currentTweetsBlockMaker];				   
}	

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view {		
	return reloading;		
}	
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view {		
	return [NSDate date];		
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == [tweetArray count]) return 35;
	else return 55;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {    
	if (indexPath.row == [tweetArray count]) {
        if (loading == NO) {      
            loading = YES;
			[[NSNotificationCenter defaultCenter] postNotificationName:@"StartLoadingNotification" object:nil];		
			[[TwitterService sharedTwitterService] prepareForOldTweets:userName 
															   tweetId:[[self.tweetArray lastObject] tweetID] 
													 tableLoadingBlock:^(NSMutableArray *tweetsArray) {                                                            
															if ([tweetsArray count]>1) {													
																[tweetsArray removeObjectAtIndex:0];
                                                                [self tableFiller:tweetsArray flag:@"old"];							                                                                                                                          
															}                                                            
															[[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLoadingView" object:nil];
															loading = NO;                                                         
														}
			 ];
	
        }
    }	
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning {    
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {	
	refreshHeaderView = nil;   
}

- (void)dealloc {   
    [currentUserName release];
	self.tweetArray = nil;
    [super dealloc];
}

@end

