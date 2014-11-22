//
//  PublicProfileViewController.h
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"

@interface FriendsProfileViewController : UIViewController<UIAlertViewDelegate>
{
    UserProfile *userProfile;

}

@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblGender;
@property (weak, nonatomic) IBOutlet UILabel *lblSportsList;

- (IBAction)clickedSignOut:(id)sender;
- (IBAction)changePassword:(id)sender;
- (IBAction)clickedInvite:(id)sender;
@end
