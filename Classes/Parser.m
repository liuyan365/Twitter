//
//  Parser.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Parser.h"
#import "Tweet.h"
#import "Downloader.h"


@implementation Parser

#define USER_IMAGE_API @"http://api.twitter.com/1/users/profile_image/%@.json?size=normal"

@synthesize resultDelegate, currentNodeContent, tweets;

-(id)init {
	self = [super init];
    return self;
}
- (NSMutableArray *)getTweets:(NSData *)data {	
	successFlag = [[NSString alloc] initWithString:@"YES"];
	tweets = [[NSMutableArray alloc] init];
	pictures = [[NSMutableDictionary alloc] init];		
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];    
	[parser setDelegate:self];
    [parser parse];
    [parser release];    
    return tweets;
}

- (void) parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qualifiedName 
	 attributes:(NSDictionary *)attributeDict {
	self.currentNodeContent = [NSMutableString string];    
	if ([elementName isEqualToString:(@"status")])	{
		currentTweet = [Tweet alloc];		
	}
}

- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qualifiedName {
	
	if ([elementName isEqualToString:(@"text")])
	{		
		if (currentTweet.content == nil) {
            currentTweet.content = self.currentNodeContent;            
        }
	}    
	if ([elementName isEqualToString:(@"created_at")])
	{	
        if (currentTweet.createdAt == nil){
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [df setLocale:locale];
            [locale release];
            [df setFormatterBehavior:NSDateFormatterBehaviorDefault];
            [df setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];     
            NSDate *date = [df dateFromString:self.currentNodeContent];        
            [df setDateFormat:@"eee MMM dd HH:mm:ss yyyy"];        
            NSString *formattedDateString = [df stringFromDate:date];
            currentTweet.createdAt = formattedDateString;
            [df release];            
        }        
	}
	if ([elementName isEqualToString:(@"name")])	{	
        if (currentTweet.userName == nil) {
			currentTweet.userName = self.currentNodeContent;
		}
	}
	if ([elementName isEqualToString:(@"screen_name")]) {		
        if (currentTweet.userScreenName == nil) {
			currentTweet.userScreenName = self.currentNodeContent; 
			if ([pictures objectForKey:currentTweet.userScreenName]==nil) {               
				NSString *userAPI = [NSString stringWithFormat:USER_IMAGE_API,self.currentNodeContent];				
				NSData *userPictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:userAPI]];				
				UIImage *userImage = [UIImage imageWithData:userPictureData];				;
				if (userImage != nil){											   
					currentTweet.userImageNormal = userImage;
					[pictures setObject:userImage forKey:currentTweet.userScreenName];
				} else {
					currentTweet.userImageNormal = [UIImage imageNamed:@"noImageSmall.png"];	
				}								
			} else {
				currentTweet.userImageNormal = [pictures objectForKey:currentTweet.userScreenName];
			}
		}		
	}	
	if ([elementName isEqualToString:(@"id")] && currentTweet.tweetID == NULL){		
		currentTweet.tweetID = self.currentNodeContent;		
	}
	if ([elementName isEqualToString:(@"error")]) {		
		currentTweet.error = self.currentNodeContent;		
		successFlag = @"NO";
		errorText = self.currentNodeContent;        
	}
	if ([elementName isEqualToString:(@"status")]) {       
		[self.tweets addObject:(currentTweet)];
		[currentTweet release];		
	}		
	self.currentNodeContent = nil;
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {    
        [self.currentNodeContent appendString:string];    
}

-(void) parserDidEndDocument: (NSXMLParser *)parser {	
	if (successFlag == @"NO") {        
        UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Alert" 
															  message:[NSString stringWithFormat:@"Error: %@",errorText] 
															 delegate:self cancelButtonTitle:@"Ok" 
													otherButtonTitles:nil];
		[simpleAlert show];
        [simpleAlert release];       	
	}
	[successFlag release];
    [pictures release];
}

-(void)dealloc {
    self.currentNodeContent = nil;
    self.tweets = nil;
    [super dealloc];
}

@end
