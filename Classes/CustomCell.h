//
//  CustomCell.h
//  ConnectAndParse
//
//  Created by RealPoc on 11/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface CustomCell : UITableViewCell {
    
    IBOutlet UIButton *pictureView;    
    IBOutlet UIView *accessoryButtonView;
    IBOutlet UILabel *userNameLabel;
    IBOutlet UILabel *contentLabel;
    IBOutlet UILabel *dateLabel;
	NSString *userScreenName;
}
+(CustomCell *)createCell:(UITableView *)tableView;
-(void)setCellContent:(Tweet *)tweet;
-(IBAction)goToUser;

@end
