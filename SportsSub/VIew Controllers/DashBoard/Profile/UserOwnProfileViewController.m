//
//  PublicProfileViewController.m
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "UserOwnProfileViewController.h"
#import "EditProfileViewController.h"
#import "SSNetworkManager.h"
#import "LogInViewController.h"
#import "AppDelegate.h"
#import "UserDefaultsHelper.h"
#import "SSDBManager.h"
#import "Utilities.h"

@implementation UserOwnProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
  
    
  /*  NSString *dateStr = @"28-09-1994";
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormat dateFromString:dateStr];

    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
 
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit|NSYearCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date  toDate:[NSDate date]  options:0];
    
    NSLog(@"Conversion: %dmin %dhours %ddays %dmoths years %d ",[conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month],[conversionInfo year]);
    
    
    [_lblAge setText:[NSString stringWithFormat:@"%d Years %d months ",[conversionInfo year],[conversionInfo month]]];
   */
    [self setTitle:@"PROFILE"];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];
   
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Medium" size:17]}];
    
    [super viewWillAppear:animated];
   // [self setTitle:@"EDIT PROFILE"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _lblEmail.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
    _lblGender.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
    _lblAge.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
    _lblSportsList.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
    
    NSDictionary *dictParam=@{@"user_id":@"1",@"latitude":@"11.1111",@"longitude":@"22.2222",
                              @"dob":@"655562074"};
    
   // NSDictionary *dictParam=@{@"user_id":@"1",@"first_name":@"vvv"};
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@editprofile",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        NSLog(@"%@",response);
    }];
   
    
    
    _imgViewProfile.layer.cornerRadius = _imgViewProfile.frame.size.width / 2;
    _imgViewProfile.clipsToBounds = YES;
    
    userProfile = [SSDBManager getDBUserProfile];
    
    [_lblEmail setText:userProfile.userEmail];
    NSString * timeStampString = userProfile.userDOB;
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    
//    NSString *stringFromDate =
    
    ///[_lblAge setText:[NSString stringWithFormat:@"%@",date]];
    
    
    
    [_lblGender setText:userProfile.userGender];
    [_lblSportsList setText:userProfile.userLastName];
    


    
    
//    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editProfileBtnPressed:)];
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit.png"] style:UIBarButtonItemStylePlain target:self action:@selector(editProfileBtnPressed:)];
    
    
    [self.navigationItem setRightBarButtonItem:customBtn];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)clickedSignOut:(id)sender
{
    NSLog(@"Clicked SignOut");
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are You Sure SignOut" message:@"press OK for signout" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.tag=500;
    [alert show];
    

}

#pragma  mark ALERT

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==500)
    {
        if (buttonIndex == 0)
        {
        
        //NetworkManager *content=[[NetworkManager alloc] init];
        NSDictionary *dictParam=@{@"user_id":[UserDefaultsHelper getStringForKey:@"userid"],@"devicetoken":@"5589435798347598437589"};
            
            [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@signout",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
                AppDelegate *appDel=(AppDelegate*) [[UIApplication sharedApplication] delegate];
                [UserDefaultsHelper setBoolValue:NO forKey:@"userlogin"];
                LogInViewController *lVC=[[LogInViewController alloc] initWithNibName:@"LogInViewController" bundle:nil];
                [appDel.window setRootViewController:lVC];
            }];
        
        NSLog(@"OK");
    }
        if (buttonIndex ==1)
        {
            NSLog(@"Cancel");
        }
    }
    if (alertView.tag==600)
    {

        NSLog(@"Old Password %@",[alertView textFieldAtIndex:0].text);
        NSLog(@"New Password :%@",[alertView textFieldAtIndex:1].text);
        
        if (buttonIndex ==1)
        {
        //NetworkManager *content=[[NetworkManager alloc] init];
        NSDictionary *dictParam=@{@"user_id":@"94",@"old_password":[alertView textFieldAtIndex:0].text,@"new_password":[alertView textFieldAtIndex:1].text};
            
            [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@changepassword",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
            
            }];
        }
    }
    
    
}


- (IBAction)changePassword:(id)sender
{
    NSLog(@"Change Password ...");
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password:" message:@"Please enter your Password:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    alert.tag=600;
      alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alert textFieldAtIndex:0].secureTextEntry = YES; //Will disable secure text entry for second textfield.
    [alert textFieldAtIndex:0].placeholder = @"Old Password"; //Will replace "Username"
    [alert textFieldAtIndex:1].placeholder = @"New Password"; //Will replace "Password"
    
    [alert addButtonWithTitle:@"Go"];
    [alert show];
}

- (IBAction)clickedInvite:(id)sender
{
    NSLog(@"Clicked Invite");
}



-(void)editProfileBtnPressed:(id)sender
{
    EditProfileViewController *epVC=[[EditProfileViewController alloc] initWithNibName:@"EditProfileViewController" bundle:nil];
    [self.navigationController pushViewController:epVC animated:YES];
}


@end
