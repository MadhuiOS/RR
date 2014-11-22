//
//  EditProfileViewController.h
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfile.h"
#import "SSDBManager.h"
#import "UIViewController+MJPopupViewController.h"
#import "POPUPViewController.h"
#import "ActionSheetPicker.h"
#import "NSDate+TCUtils.h"
#import "ActionSheetPickerCustomPickerDelegate.h"
#import "ActionSheetLocalePicker.h"
@class AbstractActionSheetPicker;

@interface EditProfileViewController : UIViewController<UIActionSheetDelegate,PopupDelegate>
{
    UserProfile *userProfile;

}
@property (nonatomic, strong) NSDate *selectedTime;
@property (nonatomic, strong) NSArray *genderArray;

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (strong, nonatomic) IBOutlet UITextField *sprotsTextField;
- (IBAction)SelectSports:(UIButton *)sender;
-(void)cancelButtonClicked:(POPUPViewController *)secondDetailViewController;
-(void)DoneButtonClicked:(POPUPViewController *)aSecondDetailViewController selectedArray:(NSArray *)array;
-(IBAction)GenderSelectedButtonClicked:(id)sender;
@end
