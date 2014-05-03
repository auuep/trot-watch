//
//  LocationHandler.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-17.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "LocationHandler.h"

@implementation LocationHandler {
    LocationHandler *locationHandler;
    CLLocationManager *manager;
}

- (id)init
{
    self = [super init];
    
    manager = [[CLLocationManager alloc] init];
    
    _currentSpeed = [[Speed alloc] initWithSpeedMS:0.0f];
 
    return self;
}

- (void)startUpdatingLocation {
    NSLog(@"LocationHandler: Starting to update location");
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
    self.isUpdating = true;
}

- (void)stopUpdatingLocation {
    NSLog(@"LocationHandler: Stop updating the location");
    [manager stopUpdatingLocation];
    self.isUpdating = false;
}

#pragma mark - CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)theManager didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location.");
    [manager stopUpdatingLocation];
    self.isUpdating = false;
}

- (void)locationManager:(CLLocationManager *)theManager didUpdateLocations:(NSArray *)locations {
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation) {
        if (currentLocation.speed > 0.0f) {
            [_currentSpeed setSpeedMeterPerSecondTo:currentLocation.speed];
        }
        else {
            [_currentSpeed setSpeedMeterPerSecondTo:0.0f];
        }
        NSLog(@"LocationHandler: set speed to: %f", currentLocation.speed);
    }
}

#pragma mark KVO methods

@end
