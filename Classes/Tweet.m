//
//  Tweet.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

@synthesize content, createdAt, error, tweetID, userName, userImageNormal, userScreenName;

-(void)dealloc {    
    self.content = nil;
    self.createdAt = nil;
    self.error = nil;
    self.tweetID = nil;
    self.userName = nil;
    self.userImageNormal = nil;
    self.userScreenName = nil;
    [super dealloc];
}
@end