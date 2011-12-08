//
//  Tweet.h
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Tweet : NSObject 

@property(nonatomic, retain) NSString *content;
@property(nonatomic, retain) NSString *createdAt;
@property(nonatomic, retain) NSString *tweetID;
@property(nonatomic, retain) NSString *error;
@property(nonatomic, retain) NSString *userName;
@property(nonatomic, retain) UIImage *userImageNormal;
@property(nonatomic, retain) NSString *userScreenName;

@end
