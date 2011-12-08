//
//  TwitterService.m
//  ConnectAndParse
//
//  Created by RealPoc on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterService.h"


@implementation TwitterService

#define CURRENT_TWEETS_API @"http://api.twitter.com/1/statuses/user_timeline.xml?include_entities=true&include_rts=true&screen_name=%@&count=20"
#define NEW_TWEETS_API @"http://api.twitter.com/1/statuses/user_timeline.xml?include_entities=true&include_rts=true&screen_name=%@&since_id=%@"
#define OLD_TWEETS_API @"http://api.twitter.com/1/statuses/user_timeline.xml?include_entities=true&include_rts=true&screen_name=%@&max_id=%@"

static TwitterService * sharedTwitterService = NULL;

+(TwitterService *)sharedTwitterService {
    if (!sharedTwitterService || sharedTwitterService == NULL) {
		sharedTwitterService = [TwitterService new];
	}
	return sharedTwitterService;
}

- (void)findTweets:(NSString *)URL 
 tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block{    
    void (^recievedBlock)(NSData *) = ^(NSData *d){		
		Parser *twitterParser = [[Parser alloc] init];
		block([twitterParser getTweets:d]);
        [twitterParser release];
    };
	[Downloader  performDownload:[NSURL URLWithString:URL] block:recievedBlock];
	[recievedBlock release];
}

- (void)prepareForCurrentTweets:(NSString *)Name 
              tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block{	
	NSString *urlString = [[NSString alloc]
						   initWithFormat:CURRENT_TWEETS_API,Name];                                
	
    [self findTweets:urlString tableLoadingBlock:block];    
    [urlString release];
}

- (void)prepareForNewTweets:(NSString *)Name 
                    tweetId:(NSString *)Id
          tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;{
    NSString *urlString = [[NSString alloc]
                           initWithFormat:NEW_TWEETS_API,Name,Id];   
    
	[self findTweets:urlString tableLoadingBlock:block];    
    [urlString release];
}

- (void)prepareForOldTweets:(NSString *)Name 
                    tweetId:(NSString *)Id
          tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;{
    NSString *urlString = [[NSString alloc]
                           initWithFormat:OLD_TWEETS_API,Name,Id];
    
    [self findTweets:urlString tableLoadingBlock:block];    
    [urlString release];
}

@end
