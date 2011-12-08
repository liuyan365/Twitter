//
//  CustomCell.m
//  ConnectAndParse
//
//  Created by RealPoc on 11/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CustomCell.h"

CustomCell *cell = nil;

@implementation CustomCell
+(CustomCell *)createCell:(UITableView *)tableView {
    
    NSString *cellIdentifier = @"CustomCell";     
    cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {        
		NSArray *queueObjects = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" 
															  owner:nil 
															options:nil];
        for (id currObject in queueObjects) {
            if ([currObject isKindOfClass:[UITableViewCell class]]) {
                cell = (CustomCell *)currObject;                
                break;
            }
        }    
    }
    return cell;
}

-(void)setCellContent:(Tweet *)tweet { 
    [pictureView setImage:[tweet userImageNormal] forState:UIControlStateNormal];       
    userNameLabel.text = [tweet userName];
    contentLabel.text = [tweet content];
    dateLabel.text = [tweet createdAt];
	userScreenName = [tweet userScreenName];
}

-(IBAction)goToUser {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"PresentOtherUsersTweets" 
                                                        object:userScreenName];
}

- (void)dealloc
{
	pictureView = nil;    
    accessoryButtonView = nil;
    userNameLabel = nil;
    contentLabel = nil;
    dateLabel = nil;
    userScreenName = nil;
    [super dealloc];
}
@end
