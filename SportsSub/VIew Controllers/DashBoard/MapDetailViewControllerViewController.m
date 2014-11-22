//
//  MapDetailViewControllerViewController.m
//  SportsSub
//
//  Created by Home on 10/6/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "MapDetailViewControllerViewController.h"


@interface MapDetailViewControllerViewController ()
@property (weak, nonatomic) IBOutlet UIView *vTopView;

@end

@implementation MapDetailViewControllerViewController

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
    
  /*
   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"BACK" style:UIBarButtonItemStylePlain target:self action:@selector(clickedBack:)];
  //  UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find_filter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(clickedBack:)];
    //  [customBtn setTintColor:[UIColor clearColor]];
    [self.navigationItem setRightBarButtonItem:customBtn];
    
    */
    [_vTopView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"common_navigationbar.png"]]];
    
    
}
- (IBAction)clickedBackButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
