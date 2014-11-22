//
//  SignUpViewController.m
//  SportsSub
//
//  Created by Home on 8/31/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "SignUpViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"


@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation SignUpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
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
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (IBAction)clickedSignUPButton:(id)sender
{
    
      [Utilities showProgressView:self.view];
    
    
    NSDictionary *dictParam=@{@"first_name":[NSString stringWithFormat:@"%@",_tfFirstName.text],@"last_name":[NSString stringWithFormat:@"%@",_tfLastName.text],@"email":[NSString stringWithFormat:@"%@",_tfEmail.text],@"password":[NSString stringWithFormat:@"%@",_tfPassword.text],@"latitude":@"23.55",@"longitude":@"87.00",@"devicetype":@"1",@"devicetoken":@"5589435798347598437589"};
    
    
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@signup",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil)
     {
        
        [Utilities hideProgressView];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    
}

- (IBAction)clickedLogIn:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma  TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // [self clickedNewLoginSubmit:self];
    
    [_tfFirstName resignFirstResponder];
    [_tfLastName resignFirstResponder];
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
    
	return YES;
}




-(void)keyboardisShowing:(NSNotification*)notification {
    //[self animateSelfView:YES];
    
    
    
}

-(void)keyboardisHiding:(NSNotification*)notification {
    //[self animateSelfView:NO];
    
    
    
}

- (void) animateSelfView: (BOOL) up
{
    if ([[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeLeft || [[UIApplication sharedApplication] statusBarOrientation]==UIDeviceOrientationLandscapeRight) {
        const int movementDistance = 220; // tweak as needed
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
        
        const int movementDistance = 100; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0,movement);
        [UIView commitAnimations];
        
        
    }
    
    
}
-(void)UpdateWithFacebookData:(NSString*)FirstName LastName:(NSString*)LastName EmailId:(NSString*)EmailID{
    self.tfFirstName.text=FirstName;
    self.tfLastName.text=LastName;
    self.tfEmail.text=EmailID;
    
}
-(void)updateWithTwitterData:(NSString *)userName
{
    [_tfFirstName setText:userName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
