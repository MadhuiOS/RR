//
//  LocationGetter.m
//  CoreLocationExample
//
//  Created by Matt on 7/9/09.
//  Copyright 2009 iCodeBlog. All rights reserved.
//

#import "LocationGetter.h"
#import <CoreLocation/CoreLocation.h>
NSString * const kSetupInfoKeyAccuracy = @"SetupInfoKeyAccuracy";
NSString * const kSetupInfoKeyDistanceFilter = @"SetupInfoKeyDistanceFilter";
NSString * const kSetupInfoKeyTimeout = @"SetupInfoKeyTimeout";

static NSString * const kAccuracyNameKey = @"AccuracyNameKey";
static NSString * const kAccuracyValueKey = @"AccuracyValueKey";

@implementation LocationGetter

@synthesize locationManager, delegate;

BOOL didUpdate = NO;
- (void)stopUpdatingLocationWithMessage:(NSString *)state {
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    
    
}
- (void)startUpdates
{
    NSLog(@"Starting Location Updates");
    
    // Create the core location manager object
    locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    
    self.setupInfo = [NSMutableDictionary dictionary];
    
    self.setupInfo[kSetupInfoKeyDistanceFilter] = @100.0;
    self.setupInfo[kSetupInfoKeyTimeout] = @30.0;
    self.setupInfo[kSetupInfoKeyAccuracy] = @(kCLLocationAccuracyHundredMeters);
    
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    self.locationManager.desiredAccuracy = [_setupInfo[kSetupInfoKeyAccuracy] doubleValue];
    
    // Once configured, the location manager must be "started"
    //
    // for iOS 8, specific user level permission is required,
    // "when-in-use" authorization grants access to the user's location
    //
    // important: be sure to include NSLocationWhenInUseUsageDescription along with its
    // explanation string in your Info.plist or startUpdatingLocation will not work.
    //
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    [self performSelector:@selector(stopUpdatingLocationWithMessage:)
               withObject:@"Timed Out"
               afterDelay:[_setupInfo[kSetupInfoKeyTimeout] doubleValue]];
}


// We want to get and store a location measurement that meets the desired accuracy.
// For this example, we are going to use horizontal accuracy as the deciding factor.
// In other cases, you may wish to use vertical accuracy, or both together.
//
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // store all of the measurements, just so we can see what kind of data we might receive
    
    // test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements
    //
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 5.0) {
        return;
    }
    
    // test that the horizontal accuracy does not indicate an invalid measurement
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    // test the measurement to see if it is more accurate than the previous measurement
    if (self.bestEffortAtLocation == nil || self.bestEffortAtLocation.horizontalAccuracy > newLocation.horizontalAccuracy) {
        // store the location as the "best effort"
        _bestEffortAtLocation = newLocation;
        
        // test the measurement to see if it meets the desired accuracy
        //
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= self.locationManager.desiredAccuracy) {
            // we have a measurement that meets our requirements, so we can stop updating the location
            //
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            //
            [self stopUpdatingLocationWithMessage:NSLocalizedString(@"Acquired Location", @"Acquired Location")];
            // we can also cancel our previous performSelector:withObject:afterDelay: - it's no longer necessary
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(stopUpdatingLocationWithMessage:) object:nil];
        }
    }
    
    // update the display with the new location data
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    // The location "unknown" error simply means the manager is currently unable to get the location.
    // We can ignore this error for the scenario of getting a single location fix, because we already have a
    // timeout that will stop the location manager to save power.
    //
    if ([error code] != kCLErrorLocationUnknown) {
        [self stopUpdatingLocationWithMessage:NSLocalizedString(@"Error", @"Error")];
    }
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status ==        kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" :   @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

// CLLocationManager Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:[NSString stringWithFormat:@"%f",manager.location.coordinate.latitude] forKey:@"lat"];
    [user setObject:[NSString stringWithFormat:@"%f",manager.location.coordinate.longitude] forKey:@"long"];
    
    NSLog(@"location info object=%@", [locations lastObject]);
    NSLog(@"%@",locations);
    
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
}
@end
