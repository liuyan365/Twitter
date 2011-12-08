//
//  ConnectAndParseDetailViewController.h
//  ConnectAndParse
//
//  Created by RealPoc on 10/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConnectAndParseDetailViewController : UIViewController { 
    
    NSMutableDictionary *biggerPictures;
    NSURLConnection *theConnection;
}

-(void)setContent:(Tweet *)tweet;

@property (nonatomic, retain)NSString* userScreenName;
@property (nonatomic, retain)IBOutlet UITextView *txtField;
@property (nonatomic, retain)IBOutlet UIImageView *imageField;
@property (nonatomic, retain)IBOutlet UILabel *nameField;
@property (nonatomic, retain)NSMutableData* pictureData;
@property (nonatomic, retain)IBOutlet UILabel *dateField;
@property (nonatomic, retain)IBOutlet UIActivityIndicatorView *loadingView;

@end

