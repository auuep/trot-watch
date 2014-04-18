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
    
    NSLog(@"Created the LocationHandler");
    return self;
}

- (void)startUpdatingLocation {
    NSLog(@"LocationHandler: Starting to update location");
}

- (void)stopUpdatingLocation {
    NSLog(@"LocationHandler: Stop updating the location");
}
@end
