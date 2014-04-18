//
//  LocationHandler.h
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-17.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Speed.h"

@interface LocationHandler : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) Speed *currentSpeed;
@property (nonatomic) BOOL isUpdating;

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;

@end
