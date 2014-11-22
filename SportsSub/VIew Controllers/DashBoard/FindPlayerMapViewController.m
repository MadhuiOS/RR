//
//  FindPlayerMapViewController.m
//  SportsSub
//
//  Created by Home on 9/6/14.
//  Copyright (c) 2014 self. All rights reserved.
//

#import "FindPlayerMapViewController.h"
#import "FilterFindPlayerViewController.h"
#import <MapKit/MapKit.h>

#import "MapDetailViewControllerViewController.h"
#import "Place.h"
#import "PlaceMark.h"
// #import "MyAnnotation.h"

// #define METERS_PER_MILE 1609.344


@interface FindPlayerMapViewController ()<MKMapViewDelegate>
{
    	NSMutableArray *reports;
    

}
@property (weak, nonatomic) IBOutlet MKMapView *MapView;

-(void)filterBtnPressed:(id)sender;
-(void)centerMap;

@end

@implementation FindPlayerMapViewController

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
    [self setTitle:@"FIND PLAYER"];
    
    
   /*
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 40.740848;
    zoomLocation.longitude= -73.991145;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.2*METERS_PER_MILE, 0.2*METERS_PER_MILE);
    [self.MapView setRegion:viewRegion animated:YES];
    */
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self setTitle:@""];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"common_navigationbar.png"] forBarMetrics:UIBarMetricsDefault];

  //  UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(filterBtnPressed:)];
    UIBarButtonItem *customBtn=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"find_filter.png"] style:UIBarButtonItemStylePlain target:self action:@selector(filterBtnPressed:)];
  //  [customBtn setTintColor:[UIColor clearColor]];
    [self.navigationItem setRightBarButtonItem:customBtn];
    

    
    self.MapView.delegate = self;
    
    
    NSDictionary *d1,*d2,*d3,*d4,*d5;
	

	
	d1=[NSDictionary dictionaryWithObjectsAndKeys:@"Sagar",@"comments",@"1",@"id",@"23.02941395",@"latitude",@"72.54620655",@"longitude",nil];
	d2=[NSDictionary dictionaryWithObjectsAndKeys:@"Nimit",@"comments",@"2",@"id",@"23.028359049999995",@"latitude",@"72.54537318333334",@"longitude",nil];
	d3=[NSDictionary dictionaryWithObjectsAndKeys:@"Jaimin",@"comments",@"3",@"id",@"23.029545",@"latitude",@"72.546036",@"longitude",nil];
	d4=[NSDictionary dictionaryWithObjectsAndKeys:@"Samurai Jack",@"comments",@"4",@"id",@"23.030050",@"latitude",@"72.546226",@"longitude",nil];
	d5=[NSDictionary dictionaryWithObjectsAndKeys:@"XYZ",@"comments",@"5",@"id",@"23.030050",@"latitude",@"72.546022",@"longitude",nil];
	
	
    
    reports=[NSMutableArray arrayWithObjects:d1,d2,d3,d4,d5,nil];
    
    
    
	// code to add pins on map
	
	for (NSDictionary *d in reports) {
		float latitude=[[d valueForKey:@"latitude"] floatValue];
		float longitude=[[d valueForKey:@"longitude"] floatValue];
		
		Place* home = [[Place alloc] init];
		home.name = [d valueForKey:@"comments"];
		home.latitude = latitude;
		home.longitude = longitude;
		
		PlaceMark *from = [[PlaceMark alloc] initWithPlace:home];
		[_MapView addAnnotation:from];
        
	}
    
    [self centerMap];
    
	
    
}

-(void)centerMap

{
	MKCoordinateRegion region;
	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 120;
	CLLocationDegrees minLon = 150;
	NSMutableArray *temp=[NSMutableArray arrayWithArray:reports];
	NSLog(@"%@",temp);
    
	for (int i=0; i<[temp count];i++) {
		Place* home = [[Place alloc] init];
		home.latitude = [[[temp objectAtIndex:i] valueForKey:@"latitude"]floatValue];
		home.longitude =[[[temp objectAtIndex:i] valueForKey:@"longitude"]floatValue];
		
		PlaceMark* from = [[PlaceMark alloc] initWithPlace:home];
		
		CLLocation* currentLocation = (CLLocation*)from ;
		if(currentLocation.coordinate.latitude > maxLat)
			maxLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.latitude < minLat)
			minLat = currentLocation.coordinate.latitude;
		if(currentLocation.coordinate.longitude > maxLon)
			maxLon = currentLocation.coordinate.longitude;
		if(currentLocation.coordinate.longitude < minLon)
			minLon = currentLocation.coordinate.longitude;
		
		region.center.latitude     = (maxLat + minLat) / 2;
		region.center.longitude    = (maxLon + minLon) / 2;
		region.span.latitudeDelta  =  maxLat - minLat;
		region.span.longitudeDelta = maxLon - minLon;
	}
	[_MapView setRegion:region animated:YES];
	
}




-(void)filterBtnPressed:(id)sender
{
    FilterFindPlayerViewController *ffpVC=[[FilterFindPlayerViewController alloc] initWithNibName:@"FilterFindPlayerViewController" bundle:nil];
    [self.navigationController pushViewController:ffpVC animated:YES];
}



#pragma mark -MapView Delegate Methods


- (MKAnnotationView *)mapView:(MKMapView *)map viewForAnnotation:(id <MKAnnotation>)annotation
{
	
	if (annotation == _MapView.userLocation)
		return nil;
	
	/*
     MKPinAnnotationView *pin = (MKPinAnnotationView *) [_MapView dequeueReusableAnnotationViewWithIdentifier: @"asdf"];
	
	if (pin == nil)
		pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"asdf"];
	else
		pin.annotation = annotation;
    */
    
    static NSString *identifier = @"myAnnotation";
    MKAnnotationView * pin = (MKAnnotationView *)[self.MapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pin)
    {
        pin = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        pin.image = [UIImage imageNamed:@"find_female.png"];
    }else {
        pin.annotation = annotation;
    }
    
    
	pin.userInteractionEnabled = YES;
	UIButton *disclosureButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	[disclosureButton setFrame:CGRectMake(0, 0, 30, 30)];
	
	pin.rightCalloutAccessoryView = disclosureButton;
	//pin.pinColor = MKPinAnnotationColorRed;
	//pin.animatesDrop = YES;
	[pin setEnabled:YES];
	[pin setCanShowCallout:YES];
	return pin;
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	NSString *strTitle = [NSString stringWithFormat:@"%@",[view.annotation title]];
	NSMutableDictionary *d;
	NSMutableArray *temp=[NSMutableArray arrayWithArray:reports];
    
	for (int i = 0; i<[temp count]; i++)
	{
		d = (NSMutableDictionary*)[temp objectAtIndex:i];
		NSString *strAddress = [NSString stringWithFormat:@"%@",[d valueForKey:@"comments"]];
		
		if([strAddress isEqualToString:strTitle])
        {
            MapDetailViewControllerViewController *mapDetailVC=[[MapDetailViewControllerViewController alloc] initWithNibName:@"MapDetailViewControllerViewController" bundle:nil];
            
          
           [self presentViewController:mapDetailVC animated:YES completion:^{
                
                [mapDetailVC.lblName setText:strAddress];
            }];
            
         
			break;
		}
		
		
	}
}






/*

#pragma mark -MapView Delegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"myAnnotation";
    MKAnnotationView * annotationView = (MKAnnotationView *)[self.MapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annotationView)
    {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    
        annotationView.image = [UIImage imageNamed:@"find_female.png"];
    }else {
        annotationView.annotation = annotation;
    }
    
    return annotationView;
    
}

-(void)mapView:(MKMapView*)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"annotationSelected" object:view]; //for the bus
//    [self segueExecute:(PalettaView*)view];
}



- (void)mapView:(MKMapView *)map annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
//    PinDetailViewController *detailView = [[PinDetailViewController alloc] init];
//    detailView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    [self presentViewController:detailView animated:YES completion:nil];
}
*/

    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
