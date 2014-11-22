//
//  EditProfileViewController.m
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "EditProfileViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"

//#import "AgePickerViewController.h"
//#import "NetworkManager.h"

@interface EditProfileViewController ()<UIPickerViewDataSource, UIPickerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIPickerView *languageSelect;
    NSMutableArray *pickerData;
    
    
   // UIDatePicker *datePicker;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imgViewProfile;

@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfAge;
@property (weak, nonatomic) IBOutlet UITextField *tfGender;
@property (weak, nonatomic) IBOutlet UITextField *tfSports;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectedAge;
@property (weak, nonatomic) IBOutlet UIView *vContainer;
@property (weak, nonatomic) IBOutlet UIView *vPickerView;

- (IBAction)clickedSaveButton:(id)sender;
- (IBAction)selectAgeFromDropDown:(id)sender;
- (IBAction)selectPhotoFromGalary:(id)sender;


@end

@implementation EditProfileViewController

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
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];
    self.navigationController.navigationBar.translucent = NO;
    
    
    [super viewWillAppear:animated];
    [self setTitle:@"EDIT PROFILE"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.genderArray=[NSArray arrayWithObjects:@"Male",@"Female",@"Others", nil];
    
    // Do any additional setup after loading the view from its nib.
    
    _imgViewProfile.layer.cornerRadius = _imgViewProfile.frame.size.width / 2;
    _imgViewProfile.clipsToBounds = YES;
    
    _vPickerView.hidden=YES;
    self.selectedTime=[NSDate date];
    
    
    userProfile = [SSDBManager getDBUserProfile];
    NSString * timeStampString = userProfile.userDOB;
    NSTimeInterval _interval=[timeStampString doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    
    [self.tfFirstName setText:userProfile.userEmail];
    [self.tfAge setText:[NSString stringWithFormat:@"%@",date]];
    [self.tfGender setText:userProfile.userGender];
    [self.tfLastName setText:userProfile.userLastName];
    [self.tfEmail setText:userProfile.userEmail];
    
    
//    self.tfFirstName.font=[UIFont fontWithName:@"HelveticaNeueThin" size:5];
//    self.tfAge.font=[UIFont fontWithName:@"HelveticaNeueThin" size:5];
//    self.tfGender.font=[UIFont fontWithName:@"HelveticaNeueThin" size:10];
//    self.tfLastName.font=[UIFont fontWithName:@"HelveticaNeueThin" size:10];
//    self.tfEmail.font=[UIFont fontWithName:@"HelveticaNeueThin" size:10];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickedSaveButton:(id)sender
{
    NSLog(@"Clicked Save Button ...");
    
    /*
    
    _imgViewProfile.image=[UIImage imageNamed:@"fav_invite.png"];
    
    NSData *imgData=UIImagePNGRepresentation(_imgViewProfile.image);
    
    NSDictionary *dictParam=@{@"user_id":@"1",@"profile_pic":imgData};
    
    [[NetworkManager sharedInstance] editUserProfilePicture:dictParam WithBlock:^(NSArray *query, NSError *errorOrNil) {
        
    }];
    
    
    */
    
//    user_id - (required)
//    first_name - (optional)
//    last_name - (optional)
//    dob - (optional) [Date of Birth preferred format - 'Y-m-d']
//    gender - (optional) //Male, Female
//    sports - (optional )  // [{"sports_id":"1","proficiency_level":"3"},{"sports_id":"2","proficiency_level":"0"},{"sports_id":"3","proficiency_level":"1"}]
//    latitude - (optional)
//    longitude - (optional)

    
    NSDictionary *dictParam=@{@"user_id":@"1",@"first_name":@"vvv"};
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@editprofile",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        
    }];
   
    
}

- (IBAction)selectAgeFromDropDown:(id)sender
{
  
    
    NSInteger minuteInterval = 5;
    //clamp date
    NSInteger referenceTimeInterval = (NSInteger)[self.selectedTime timeIntervalSinceReferenceDate];
    NSInteger remainingSeconds = referenceTimeInterval % (minuteInterval *60);
    NSInteger timeRoundedTo5Minutes = referenceTimeInterval - remainingSeconds;
    if(remainingSeconds>((minuteInterval*60)/2)) {/// round up
        timeRoundedTo5Minutes = referenceTimeInterval +((minuteInterval*60)-remainingSeconds);
    }
    
    self.selectedTime = [NSDate dateWithTimeIntervalSinceReferenceDate:(NSTimeInterval)timeRoundedTo5Minutes];
    
    ActionSheetDatePicker *datePicker = [[ActionSheetDatePicker alloc] initWithTitle:@"Select a Date" datePickerMode:UIDatePickerModeDateAndTime selectedDate:self.selectedTime target:self action:@selector(timeWasSelected:element:) origin:sender];
    datePicker.minuteInterval = minuteInterval;
    [datePicker showActionSheetPicker];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];

    }else if (buttonIndex==1){
        @try {
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            
            [self presentViewController:picker animated:YES completion:^{
                
            }];
            
        }
        @catch (NSException *exception) {
            //
            NSLog(@"%@",exception);
        }
        @finally {
            //
        }

            }}


- (IBAction)selectPhotoFromGalary:(id)sender
{
    UIActionSheet *action=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Camera Roll", nil];
    [action showInView:self.view];
    
    
    
    
}

#pragma mark ImagePickerView Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    
    @try {
        [picker dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
        }];
        
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        if(!(image.imageOrientation == UIImageOrientationUp ||
             image.imageOrientation == UIImageOrientationUpMirrored))
        {
            CGSize imgsize = image.size;
            UIGraphicsBeginImageContext(imgsize);
            [image drawInRect:CGRectMake(0.0, 0.0, imgsize.width, imgsize.height)];
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
        
        _imgViewProfile.image=image;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        //
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    @try {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    @catch (NSException *exception) {
        //
    }
    @finally {
        //
    }
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    
}


#pragma  TextField Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // [self clickedNewLoginSubmit:self];
    
    [_tfFirstName resignFirstResponder];
    [_tfLastName resignFirstResponder];
    [_tfEmail resignFirstResponder];
    [_tfGender resignFirstResponder];
    [_tfAge resignFirstResponder];
    [_tfSports resignFirstResponder];
    
	return YES;
}




#pragma UIPickerViewDataSource

//Columns in picker views

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView; {
    return 1;
}
//Rows in each Column

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component; {
    return [pickerData count];
}

#pragma UIPickerViewDelegate
// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
-(NSString*) pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    //Write the required logic here that should happen after you select a row in Picker View.
    
    [_tfAge setText:[pickerData objectAtIndex:row]];
    
   /* _vPickerView.hidden=YES;
    [languageSelect removeFromSuperview];
    [pickerData removeAllObjects];
    pickerData=nil;
    */
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





- (IBAction)SelectSports:(UIButton *)sender {
    SSDBManager *database=[SSDBManager sharedInstance];
    NSLog(@"%@",[database getDBSportsList]);
    
    
    
    
    
    POPUPViewController *popUpViewController = [[POPUPViewController alloc] initWithNibName:@"POPUPViewController" bundle:nil];
    popUpViewController.contentArray=[[database getDBSportsList] copy];
    popUpViewController.selectionType=@"multi";
    NSLog(@"%@",popUpViewController.contentArray);
    
    
    popUpViewController.delegate = self;
    [self presentPopupViewController:popUpViewController animationType:MJPopupViewAnimationSlideBottomTop];
}
- (void)cancelButtonClicked:(POPUPViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}
- (void)DoneButtonClicked:(POPUPViewController *)aSecondDetailViewController selectedArray:(NSArray*)array
{
    NSLog(@"%@",array);
    self.sprotsTextField.text=@"";
    
    for (int i=0; i<[array count]; i++) {
        if (i==0) {
            self.sprotsTextField.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        }else{
            self.sprotsTextField.text=[NSString stringWithFormat:@"%@,%@",self.sprotsTextField.text,[array objectAtIndex:i]];
        }
        
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideTopBottom];
}

-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    //self.tfWhen = selectedTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss a"];
    self.tfAge.text = [dateFormatter stringFromDate:selectedTime];
}
-(IBAction)GenderSelectedButtonClicked:(id)sender{
 [ActionSheetStringPicker showPickerWithTitle:@"Select Gender" rows:self.genderArray initialSelection:0 target:self successAction:@selector(GenderSelected:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
}
- (void)actionPickerCancelled:(id)sender {
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}
-(void)GenderSelected:(NSNumber*)selected{
    self.tfGender.text=[self.genderArray objectAtIndex:[selected integerValue]];
    
}
@end
