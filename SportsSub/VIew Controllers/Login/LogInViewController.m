//
//  LogInViewController.m
//  SportsSub
//
//  Created by Home on 8/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import "SSAlertView.h"
#import "SSDBManager.h"
#import "UserDefaultsHelper.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
@interface LogInViewController ()<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void) getTwitterInfo;
-(void)getFaceBookInfo;

@end

@implementation LogInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.signupButton.layer.borderWidth=1.0;
    self.signupButton.layer.borderColor=[[UIColor colorWithRed:179/255 green:179/255 blue:171/255 alpha:1.0] CGColor];
    
}


- (void)viewDidLoad
{
    [UserDefaultsHelper setBoolValue:NO forKey:@"userlogin"];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector (keyboardisShowing:)
     name: UIKeyboardDidShowNotification
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector (keyboardisHiding:)
     name: UIKeyboardDidHideNotification
     object:nil];
    
    _tfUserName.text= @"first@gmail.com";
    _tfPassword.text = @"first";
    _tfUserName.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
     _tfPassword.font=[UIFont fontWithName:@"HelveticaNeueThin" size:15];
    
    
}
-(void)viewDidLayoutSubviews{
    if (IS_IPHONE5) {
        
    }else{
        
        
        
        [(UIScrollView*)self.bgView setContentSize:CGSizeMake(320, 450)];
        
    }
}
//-(void)viewDidLayoutSubviews{
//    FBLoginView *loginView = [[FBLoginView alloc] init];
//    loginView.frame=CGRectMake(12, 440, 147, 37);
//    loginView.backgroundColor=[UIColor clearColor];
//
//    //loginView.center = self.view.center;
//    loginView.delegate = self;
//    loginView.readPermissions = @[@"public_profile", @"email"];
//    [self.view addSubview:loginView];
//
//}
-(void)loginView{
    
}
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    
    
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    
    self.loggedInUser = user;
    
    NSLog(@"usr_first_name::%@",user.first_name);
    NSLog(@"usr_last_name::%@",user.last_name);
    NSLog(@"usr_b_day::%@",user.birthday);
    NSLog(@"usr_b_email::%@",[user objectForKey:@"email"]);

}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:@"username"];
    [defaults removeObjectForKey:@"password"];
    [defaults removeObjectForKey:@"birthday"];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (IBAction)facebookLoginClicked:(id)sender
{
    [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:@"publish_actions",@"publish_stream",@"read_mailbox",@"email", nil] allowLoginUI:YES completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
    {
        
        if (FBSession.activeSession.isOpen)
        {
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
////                NSLog(@"%@", [result objectForKey:@"gender"]);
//                NSLog(@"%@", [result objectForKey:@"first_name"]);
//                NSLog(@"%@", [result objectForKey:@"last_name"]);
//                NSLog(@"%@", [result objectForKey:@"email"]);
//                
//                
                SignUpViewController *supVC=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
                
                [self presentViewController:supVC animated:YES completion:^{
                    
                    [supVC UpdateWithFacebookData:[result objectForKey:@"first_name"] LastName:[result objectForKey:@"last_name"] EmailId:[result objectForKey:@"email"]];
                }];
            }];
            
        }
   }];
}


- (IBAction)clickedLogIn:(id)sender
{

    [Utilities showProgressView:self.view];
    
    NSDictionary *dictParam=@{@"email":[NSString stringWithFormat:@"%@",_tfUserName.text],@"password":[NSString stringWithFormat:@"%@",_tfPassword.text],@"latitude":@"30.0909",@"longitude":@"87.00",@"devicetype":@"1",@"devicetoken":[UserDefaultsHelper getStringForKey:@"devicetoken"]};
    NSLog(@"%@",dictParam);
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@login",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        NSLog(@"___________Finished_______%@",response);
        [Utilities hideProgressView];
        
        NSLog(@"%@",[response valueForKey:@"content"]);
        NSLog(@"%@",[response valueForKey:@"error"]);
        if ([[response valueForKey:@"error"] isKindOfClass:[NSNull class]])
        {
            // userId = 1;
            
            [UserDefaultsHelper setStringValue:[[response valueForKey:@"content"] objectForKey:@"userId"] forKey:@"userid"];
            
            if ([response valueForKey:@"message"]!=nil) {
                if ([[response valueForKey:@"message"] isEqualToString:@"Invalid login detail."]) {
                    [SSAlertView  showWithTitle:@"Login Error" message:[response valueForKey:@"message"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
                    
                    
                }
                else
                {
                    
                    AppDelegate *appDelegate=(AppDelegate*) [[UIApplication sharedApplication] delegate];
                    
                    [UserDefaultsHelper setBoolValue:YES forKey:@"userlogin"];
                    
                    if([appDelegate respondsToSelector:@selector(createTabbar)]){
                        
                        [[[UIApplication sharedApplication] delegate] performSelector:@selector(createTabbar)];
                    }
                    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@userDetail/%@",DUURL,[UserDefaultsHelper getStringForKey:@"userid"]] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
                        NSLog(@"%@",response);
                        NSLog(@"%@",[errorOrNil description]);
                        [[SSDBManager sharedInstance] saveUserProfile:[response objectForKey:@"content"]];
                    }];
                    
                }
            }
            
        }
        else
        {
            [SSAlertView  showWithTitle:@"Login Error" message:[response valueForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitle:nil];
        }
        
    }];
    
}

- (IBAction)clickedSignUPButton:(id)sender
{
    SignUpViewController *supVC=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self presentViewController:supVC animated:YES completion:^{
        
    }];
}

#pragma  TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // [self clickedNewLoginSubmit:self];
    
    [_tfUserName resignFirstResponder];
    [_tfPassword resignFirstResponder];
    return YES;
}

-(void)keyboardisShowing:(NSNotification*)notification
{
    //[self animateSelfView:YES];
    
    
}

-(void)keyboardisHiding:(NSNotification*)notification {
    // [self animateSelfView:NO];
    
    
    
}

- (void) animateSelfView: (BOOL) up
{
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeRight) {
        const int movementDistance = 180; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0,movement);
        [UIView commitAnimations];
    }
    else
    {
        
        const int movementDistance = 60; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0,movement);
        [UIView commitAnimations];
        
        
    }
    
    
}

- (IBAction)clickedForgotPassword:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Forgot Password:" message:@"Please enter your Email:" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    alert.tag=600;
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].placeholder = @"Please Enter Email..."; //Will replace "Username"
    
    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==600)
    {
        if (buttonIndex == 0)
        {
            NSDictionary *dict=[NSDictionary dictionaryWithObject:[alertView textFieldAtIndex:0].text forKey:@"email"];
            [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@forgotPassword",DUURL] requestType:@"POST" requestrequestData:dict WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
            }];
        }
    }
}
- (IBAction)loginWithFacebook:(id)sender
{
    
}


- (IBAction)loginWithTwitter:(id)sender
{
    // Twitter
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        
        [self getTwitterInfo];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter"
                                                        message:@"Twitter integration is not available.  A Twitter account must be set up on your device."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    
}


-(void)getFaceBookInfo
{
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            
            
            if (accounts.count > 0)
            {
                //ACAccount *facebookAccount = [accounts objectAtIndex:0];
                
                
                /*// Creating a request to get the info about a user on Twitter
                 
                 SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:twitterAccount.accountDescription forKey:@"screen_name"]];
                 [twitterInfoRequest setAccount:twitterAccount];
                 
                 // Making the request
                 
                 [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                 
                 // Check if we reached the reate limit
                 
                 if ([urlResponse statusCode] == 429) {
                 NSLog(@"Rate limit reached");
                 return;
                 }
                 
                 // Check if there was an error
                 
                 if (error) {
                 NSLog(@"Error: %@", error.localizedDescription);
                 return;
                 }
                 
                 // Check if there is some response data
                 
                 if (responseData) {
                 
                 NSError *error = nil;
                 NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                 
                 //    NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                 NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
                 
                 
                 SignUpViewController *supVC=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
                 
                 [self presentViewController:supVC animated:YES completion:^{
                 
                 [supVC updateWithTwitterData:name];
                 }];
                 
                 
                 }
                 });
                 }];
                 */
            }
            
        } else {
            NSLog(@"No access granted");
        }
    }];
    
    
}


- (void) getTwitterInfo
{
    // Request access to the Twitter accounts
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0)
            {
                ACAccount *twitterAccount = [accounts objectAtIndex:0];
                
                // Creating a request to get the info about a user on Twitter
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:twitterAccount.accountDescription forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                
                // Making the request
                
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        // Check if we reached the reate limit
                        
                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit reached");
                            return;
                        }
                        
                        // Check if there was an error
                        
                        if (error) {
                            NSLog(@"Error: %@", error.localizedDescription);
                            return;
                        }
                        
                        // Check if there is some response data
                        
                        if (responseData) {
                            
                            NSError *error = nil;
                            NSArray *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
                            
                            //    NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
                            NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
                            
                            
                            SignUpViewController *supVC=[[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
                            
                            [self presentViewController:supVC animated:YES completion:^{
                                
                                [supVC updateWithTwitterData:name];
                            }];
                            
                            
                        }
                    });
                }];
            }
            
        } else {
            NSLog(@"No access granted");
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
