//
//  SendInviteViewController.h
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"
#import "POPUPViewController.h"
#import "ActionSheetPicker.h"
#import "NSDate+TCUtils.h"
#import "ActionSheetPickerCustomPickerDelegate.h"
#import "ActionSheetLocalePicker.h"
@class AbstractActionSheetPicker;

@interface SendInviteViewController : UIViewController
@property (nonatomic,strong) IBOutlet UITextField *sportsTextFiled;
@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (nonatomic, strong) NSDate *selectedTime;

-(IBAction)DateSelect:(id)sender;

@end
