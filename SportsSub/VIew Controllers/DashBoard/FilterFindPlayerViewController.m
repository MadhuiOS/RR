//
//  FilterFindPlayerViewController.m
//  SportsSub
//
//  Created by Home on 9/2/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "FilterFindPlayerViewController.h"
#import "SSNetworkManager.h"
#import "Utilities.h"
@interface FilterFindPlayerViewController ()
{
    
    UILabel *lblDistanceValue;
    UILabel *lblAgeValue;
    
    
}
@property (weak, nonatomic) IBOutlet UIView *vMainView;
//@property (weak, nonatomic) IBOutlet UISlider *slAge;
@property (weak, nonatomic) IBOutlet UISlider *slDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnMale;
@property (weak, nonatomic) IBOutlet UIButton *btnFemale;
@property (weak, nonatomic) IBOutlet UIButton *btnBoth;

@end

@implementation FilterFindPlayerViewController

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
    [self configureLabelSlider];

    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20]
                              }];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [super viewWillAppear:animated];
    [self setTitle:@"FIND PLAYER"];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@""];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateSliderLabels];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find_filter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(filterButtonPressed:)];
    

    //  [customBtn setTintColor:[UIColor clearColor]];
    [self.navigationItem setRightBarButtonItem:customBtn];
    
    

    [_slDistance setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
//    [_slAge setThumbImage:[UIImage imageNamed:@"slider.png"] forState:UIControlStateNormal];
    
    lblDistanceValue=[[UILabel alloc] init];
    lblDistanceValue.font = [UIFont fontWithName:@"Arial" size:(10.0)];
    [_vMainView addSubview:lblDistanceValue];
    
    lblAgeValue=[[UILabel alloc] init];
    lblAgeValue.font = [UIFont fontWithName:@"Arial" size:(10.0)];
    [_vMainView addSubview:lblAgeValue];
    
    [_slDistance addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
//    [_slAge addTarget:self action:@selector(updateSliderValue:) forControlEvents:UIControlEventValueChanged];
    
}


- (void)updateSliderValue:(id)slider
{
    
    if ([slider tag]== 300)
    {
         NSInteger v = _slDistance.value;
        [lblDistanceValue setFrame:CGRectMake([self xPositionFromSliderValue:_slDistance]-5, _slDistance.frame.origin.y-20, 100, 30)];
        [lblDistanceValue setText:[NSString stringWithFormat:@"%d km",v]];
    }
    

    
}

- (float)xPositionFromSliderValue:(UISlider *)aSlider;
{
    float sliderRange = aSlider.frame.size.width - aSlider.currentThumbImage.size.width;
    float sliderOrigin = aSlider.frame.origin.x + (aSlider.currentThumbImage.size.width / 2.0);
    
float sliderValueToPixels = ((((aSlider.value-aSlider.minimumValue)/(aSlider.maximumValue-aSlider.minimumValue))*sliderRange) + sliderOrigin);
    
    return sliderValueToPixels;
}


- (IBAction)selectMaleButton:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    btn.selected=!btn.selected;
    
    [_btnMale setSelected:YES];
    [_btnFemale setSelected:NO];
    [_btnBoth setSelected:NO];
  
}
- (IBAction)selectFemaleButton:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    btn.selected=!btn.selected;
    
    [_btnMale setSelected:NO];
    [_btnFemale setSelected:YES];
    [_btnBoth setSelected:NO];
    
   
    
}
- (IBAction)selectBothButton:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    btn.selected=!btn.selected;
    
    [_btnMale setSelected:NO];
    [_btnFemale setSelected:NO];
    [_btnBoth setSelected:YES];
    
   
    
}

- (IBAction)clickedSportsName:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    btn.selected=!btn.selected;
    
}


-(void)filterButtonPressed:(id)sender
{
    
    
    NSString *strGender;
    
    
//    if ([_btnMale isSelected])
//    {
   //   NSLog(@"Male");
//        strGender=@"Male";
//    }
//    if ([_btnFemale isSelected])
//    {
//       //  NSLog(@"Female");
//         strGender=@"Female";
//    }
//    if ([_btnBoth isSelected])
//    {
//       //  NSLog(@"Group");
//         strGender=@"Group";
//    }
    
    NSDictionary *dictParam=@{@"distance":@"1000",@"minAge":@"15",@"maxAge":@"50",@"sport":@"1,2,3"};
    
    NSLog(@"Filter dictParam :%@",dictParam);
    
    [[SSNetworkManager sharedInstance] requestURL:[NSString stringWithFormat:@"%@searchplayer",DUURL] requestType:@"POST" requestrequestData:dictParam WithBlock:^(NSDictionary *response, NSError *errorOrNil) {
        NSLog(@"%@",response);
    }];
    
    
    NSDictionary *dictParam2=@{@"distance":@"ka",@"gender":@"male",@"latitude":@"30.0909",@"longitude":@"87.00",@"minAge":@"15",@"maxAge":@"12",@"sport":@"cricket"};
    
//    NSLog(@"Filter dictParam :%@",dictParam2);
//    
//    NSLog(@"lblAgeValue Text :%@",[lblAgeValue.text stringByReplacingOccurrencesOfString:@" years" withString:@""]);
//     NSLog(@"lblDistanceValue Text :%@",[lblDistanceValue.text stringByReplacingOccurrencesOfString:@" km" withString:@""]);
//    
    
    
    NSMutableString *strSports = [[NSMutableString alloc]init];
    [strSports appendString:@""];
    
    
    
    
    
    
    
     UIView *buttonsView=[self.view viewWithTag:2000];
    
    for (UIButton *selectedButton in buttonsView.subviews)
    {
        if ([selectedButton isKindOfClass:[UIButton class]])
        {
            
            if (selectedButton.isSelected)
            {
            [strSports appendString:selectedButton.titleLabel.text];
            [strSports appendString:@","];
            }

        }
    }

    
}



#pragma mark -
#pragma mark - Label  Slider

- (void) configureLabelSlider
{
    self.labelSlider.minimumValue = 12;
    self.labelSlider.maximumValue = 50;
    
    self.labelSlider.lowerValue = 12;
    self.labelSlider.upperValue = 50;
    
    self.labelSlider.minimumRange = 1;
}

- (void) updateSliderLabels
{
    // You get get the center point of the slider handles and use this to arrange other subviews
    
    CGPoint lowerCenter;
    lowerCenter.x = (self.labelSlider.lowerCenter.x + self.labelSlider.frame.origin.x);
    lowerCenter.y = (self.labelSlider.center.y - 30.0f);
    self.lowerLabel.center = lowerCenter;
    self.lowerLabel.text = [NSString stringWithFormat:@"%d years", (int)self.labelSlider.lowerValue];
    
    CGPoint upperCenter;
    upperCenter.x = (self.labelSlider.upperCenter.x + self.labelSlider.frame.origin.x);
    upperCenter.y = (self.labelSlider.center.y - 30.0f);
    self.upperLabel.center = upperCenter;
    self.upperLabel.text = [NSString stringWithFormat:@"%d years", (int)self.labelSlider.upperValue];
}

- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    [self updateSliderLabels];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
