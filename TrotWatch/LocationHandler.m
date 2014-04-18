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
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (id)init
{
    self = [super init];
    
    manager = [[CLLocationManager alloc] init];
    
    geocoder = [[CLGeocoder alloc] init];
    
    _currentSpeed = [[Speed alloc] initWithSpeedMS:0];
    
    NSLog(@"Created the LocationHandler");
    //[self addObserver:self forKeyPath:@"isUpdating" options:NSKeyValueObservingOptionNew context:nil];
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

#pragma mark CLLocationManagerDelegate methods
-(void)locationManager:(CLLocationManager *)themanager didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location. :/");
    [manager stopUpdatingLocation];
    self.isUpdating = false;
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"LocationHandler: New location: %@", [locations lastObject]);

    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation) {
        [_currentSpeed setSpeedMeterPerSecondTo:currentLocation.speed];
        NSLog(@"LocationHandler: set speed to: %f", currentLocation.speed);
    }
}

#pragma mark KVO methods

@end
