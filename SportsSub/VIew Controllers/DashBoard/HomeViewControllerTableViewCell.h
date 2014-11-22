//
//  HomeViewControllerTableViewCell.h
//  SportsSub
//
//  Created by Home on 9/1/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UserReceivedInvitation.h"

@protocol HomeViewControllerTableViewCellDelegate<NSObject>

-(void)acceptInvitation:(NSNumber *)invitationId;
-(void)rejectInvitation:(NSNumber *)invitationId;

@end


@interface HomeViewControllerTableViewCell : UITableViewCell

{

}

@property(nonatomic,weak) id<HomeViewControllerTableViewCellDelegate> delegate;

-(void)updateCell:(UserReceivedInvitation *)userInv;
@end
