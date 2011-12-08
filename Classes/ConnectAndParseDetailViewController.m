//
//  ConnectAndParseDetailViewController.m
//  ConnectAndParse
//
//  Created by RealPoc on 10/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ConnectAndParseDetailViewController.h"
#import "Downloader.h"

@implementation ConnectAndParseDetailViewController

@synthesize txtField,imageField,nameField,dateField,loadingView,userScreenName,pictureData;

#define BIGGER_PICTURE_API @"http://api.twitter.com/1/users/profile_image/%@.json?size=bigger"

-(void)setContent:(Tweet *)tweet {
	self.nameField.text = tweet.userName;
    self.txtField.text = tweet.content;
    self.dateField.text = tweet.createdAt;
    self.userScreenName = tweet.userScreenName; 
}

- (void)viewDidLoad {	
    self.imageField.image = nil; 
    biggerPictures = [[NSMutableDictionary alloc]init];    
    [super viewDidLoad];    
}

- (void)viewDidAppear:(BOOL)animated {
    self.imageField.image = nil; 
    if([biggerPictures objectForKey:self.userScreenName]==nil){      
       [Downloader performDownload:[NSURL URLWithString:[NSString stringWithFormat:BIGGER_PICTURE_API,userScreenName]]          
												  block:^(NSData *data) {													  
													  UIImage *userImage = [UIImage imageWithData:data];
													  if (userImage != nil) {
														  self.imageField.image = userImage;
														  [biggerPictures setObject:userImage forKey:userScreenName];
													  } else {
														  self.imageField.image = [UIImage imageNamed:@"noImage.png"];				
                                                      }
													  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
													  [self.loadingView stopAnimating]; 
        }];     
        [self.loadingView startAnimating];        
	}
    else self.imageField.image = [biggerPictures objectForKey:userScreenName];    
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated {
    self.imageField.image = nil;
}
@end
