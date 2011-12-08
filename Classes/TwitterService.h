//
//  TwitterService.h
//  ConnectAndParse
//
//  Created by RealPoc on 11/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Downloader.h"
#import "Parser.h"


@interface TwitterService : NSObject {    
      
}

+ (TwitterService *)sharedTwitterService;

- (void)findTweets:(NSString *)URL 
 tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;

- (void)prepareForCurrentTweets:(NSString *)Name 
              tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;
- (void)prepareForNewTweets:(NSString *)Name 
          tweetId:(NSString *)Id
          tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;
- (void)prepareForOldTweets:(NSString *)Name 
          tweetId:(NSString *)Id
          tableLoadingBlock:(void (^)(NSMutableArray *tweetsArray))block;
@end
