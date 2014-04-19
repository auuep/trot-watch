//
//  Speed.h
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-18.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Speed : NSObject

@property (nonatomic) double tempoKm;
@property (nonatomic) double tempoMile;
@property (nonatomic) double speedMeterPerSecond;
@property (nonatomic) double speedKmPerHour;

-(id)initWithSpeedMS:(double)speed;
-(void)setSpeedMeterPerSecondTo:(double)speedMeterPerSecond;

@end
