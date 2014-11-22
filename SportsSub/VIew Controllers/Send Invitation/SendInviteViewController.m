//
//  SendInviteViewController.m
//  SportsSub
//
//  Created by Home on 9/3/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "SendInviteViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"
#import "SSDBManager.h"
#import "AppDelegate.h"
#import "SSNetworkManager.h"

@interface SendInviteViewController ()<UITextViewDelegate,PopupDelegate>
{
}

@property (weak, nonatomic) IBOutlet UITextField *tfWhere;
@property (weak, nonatomic) IBOutlet UITextField *tfWhen;
@property (weak, nonatomic) IBOutlet UITextView *tvDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnSelectSports;
- (IBAction)clickedSendInviteButton:(id)sender;
- (IBAction)clickedSelectSports:(id)sender;

@end

@implementation SendInviteViewController

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
    
    AppDelegate *appDelegate=(AppDelegate*) [[UIApplication sharedApplication] delegate];
    [appDelegate CurrentLocationUpdate];
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    [super viewWillAppear:animated];
    [self setTitle:@"INVITE"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@""];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    _tvDescription.layer.borderWidth=1.0;
    _tvDescription.layer.borderColor=[UIColor lightGrayColor].CGColor;

    _tvDescription.delegate = self;
    _tvDescription.text = @"please enter text here...";
    _tvDescription.textColor = [UIColor lightGrayColor]; //optional
     self.selectedTime = [NSDate date];
    
    
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


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    // [self clickedNewLoginSubmit:self];
    
    [_tfWhere resignFirstResponder];
    [_tfWhen resignFirstResponder];
    [_tvDescription resignFirstResponder];
	return YES;
}


- (IBAction)clickedSelectSports:(id)sender
{
    SSDBManager *database=[SSDBManager sharedInstance];
    NSLog(@"%@",[database getDBSportsList]);
    
    
    
    
    
    POPUPViewController *popUpViewController = [[POPUPViewController alloc] initWithNibName:@"POPUPViewController" bundle:nil];
    popUpViewController.contentArray=[[database getDBSportsList] copy];
    popUpViewController.selectionType=@"multi";
    NSLog(@"%@",popUpViewController.contentArray);
    
    
    popUpViewController.delegate = self;
    [self presentPopupViewController:popUpViewController animationType:MJPopupViewAnimationSlideBottomTop];
    
    //[content getSportsListWithBlock:^(NSArray *query, NSError *errorOrNil) {
        
      //  NSLog(@"query :%@",query);
        
        
//        if(dropDown == nil) {
//            CGFloat f = 120.0;
//            dropDown = [[NIDropDown alloc]showDropDown:_btnSelectSports :&f :query :@"down"];
//            dropDown.delegate = self;
//        }
//        else {
//            [dropDown hideDropDown:sender];
//            [self rel];
//        }
        
    //}];

    
    
}


-(void)rel
{
    //dropDown = nil;
}



#pragma KeyBoard Notifications


-(void)keyboardisShowing:(NSNotification*)notification
{
//    [dropDown hideDropDown:_btnSelectSports];
    [self rel];
    
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
        
        const int movementDistance = 180; // tweak as needed
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = (up ? -movementDistance : movementDistance);
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0,movement);
        [UIView commitAnimations];
        
        
    }
    
    
}




#pragma UITextview Delegates

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"please enter text here..."]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"please enter text here...";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}


- (BOOL)textView:(UITextView *)txtView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [txtView resignFirstResponder];
    return NO;
}





- (IBAction)clickedSendInviteButton:(id)sender
{
    NSLog(@"Clicked Send Invite Button...");
    
    
    NSString *strSportsId;
    
    if ([_btnSelectSports.titleLabel.text isEqualToString:@"cricket"])
    {
       strSportsId=@"1";
    }
    if ([_btnSelectSports.titleLabel.text isEqualToString:@"volly ball"])
    {
         strSportsId=@"2";
    }
    
    if ([_btnSelectSports.titleLabel.text isEqualToString:@"hokye"])
    {
         strSportsId=@"3";
    }
    
    NSDictionary *dictParam;
    
    if (![_btnSelectSports.titleLabel.text isEqualToString:@"Select Sports"])
    {
    
        
    }
    else
    {
        
        
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Select Sport"
                                                        message:@"Please Select any sports"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        
    
    }

    dictParam=@{@"from":@"3",@"to":@"1",@"latitude":@"30.0909",@"longitude":@"87.00",@"intructions":_tvDescription.text,@"when":@"tomamrrow",@"where":@"",@"sport_id":@"1"};
    
    NSLog(@"dictParam :%@",dictParam);
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@invitePlayer",DUINVITEURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        
        NSLog(@"%@",response);
        
    }];
    
  /*
   
    [Utilities showProgressView:self.view];
    
    [content sendInvitation:dictParam WithBlock:^(NSArray *query, NSError *errorOrNil)
     {
         NSLog(@"___________Finished_______%@",query);
         [Utilities hideProgressView];
     }];
    */
    
    
    
}


- (void)cancelButtonClicked:(POPUPViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
- (void)DoneButtonClicked:(POPUPViewController *)aSecondDetailViewController selectedArray:(NSArray*)array
{
    NSLog(@"%@",array);
    self.sportsTextFiled.text=@"";
    
    for (int i=0; i<[array count]; i++) {
        if (i==0) {
            self.sportsTextFiled.text=[NSString stringWithFormat:@"%@",[array objectAtIndex:i]];
        }else{
            self.sportsTextFiled.text=[NSString stringWithFormat:@"%@,%@",self.sportsTextFiled.text,[array objectAtIndex:i]];
        }
        
    }
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}
-(IBAction)DateSelect:(id)sender{
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
-(void)timeWasSelected:(NSDate *)selectedTime element:(id)element {
    //self.tfWhen = selectedTime;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd:MM:YY h:mm a"];
    self.tfWhen.text = [dateFormatter stringFromDate:selectedTime];
}

@end
