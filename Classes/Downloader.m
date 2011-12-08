//
//  Downloader.m
//  ConnectAndParse
//
//  Created by RealPoc on 08.10.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Downloader.h"

@implementation Downloader
@synthesize xmlData, tableContentLoadingBlock;

+ (void)performDownload:(NSURL *) inputURL  block:(void (^)(NSData *data))block { 	
	Downloader *downloader = [[Downloader alloc] init];	
    downloader.tableContentLoadingBlock = block;
	[downloader makeConnection:inputURL];
	[downloader release];
}

- (void)makeConnection:(NSURL *) inputURL {  
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:inputURL
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy
                                          timeoutInterval:60.0];
    
	NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];    
	if (theConnection) {		
        self.xmlData = [NSMutableData data];        		
    }  
    [theConnection release];  
}

- (void)backGroundOp {    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init]; 	
    if (self.tableContentLoadingBlock != nil) self.tableContentLoadingBlock(xmlData);
    [pool release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {   
    [xmlData appendData:data];	
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];	
    [self performSelectorInBackground:@selector(backGroundOp) withObject:nil];  
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error { 
	UIAlertView *simpleAlert = [[UIAlertView alloc] initWithTitle:@"Alert" 
														  message:@"Connection failed!" 
														 delegate:self 
												cancelButtonTitle:@"Ok" otherButtonTitles:nil];	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];		
	[simpleAlert show];
	[simpleAlert release];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"CloseLoadingView" object:nil];	
}

- (void)dealloc {
	[tableContentLoadingBlock release];
    [xmlData release];
    [super dealloc];
}

@end
