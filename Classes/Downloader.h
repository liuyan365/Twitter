//
//  Downloader.h
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Downloader : NSObject
{
    NSMutableData *xmlData;    
    void (^tableContentLoadingBlock)(NSData *);
}

@property (nonatomic, copy) void (^tableContentLoadingBlock)(NSData *);
@property (nonatomic, retain) NSMutableData *xmlData;

+ (void)performDownload:(NSURL *) inputURL block:(void (^)(NSData *data))block;
- (void)backGroundOp;
- (void)makeConnection:(NSURL *) inputURL;

@end


