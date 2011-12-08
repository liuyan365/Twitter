//
//  Parser.h
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Tweet.h"

@protocol ParserGotErrorDelegate;

@interface Parser : NSObject <NSXMLParserDelegate> {	
		
	NSString *errorText;
	NSData *ourxmlData;
	NSMutableDictionary *pictures;		
	NSString *successFlag;
	Tweet *currentTweet;
	id <ParserGotErrorDelegate> resultDelegate;  	
}
@property(nonatomic, assign) id <ParserGotErrorDelegate> resultDelegate;
@property(nonatomic, retain) NSMutableString* currentNodeContent;
@property(nonatomic, retain) NSMutableArray *tweets;

- (id)init;
- (NSMutableArray *)getTweets:(NSData *)data;

@end

@protocol ParserGotErrorDelegate
-(void)gotError:(NSString *)errorType;
-(void)endSuccessful:(NSMutableArray *)tweetsReturned;
-(void)main;
@end


