//
//  Speed.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-18.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "Speed.h"

@implementation Speed

-(id)initWithSpeedMS:(double)speed {
    self = [super init];
    
    if (self) {
        self.speedMeterPerSecond = speed;
    }
    return self;
}

- (id)init
{
    return [self initWithSpeedMS:0.0];
}

-(void)setSpeedMeterPerSecondTo:(double)speedMeterPerSecond {
    
    if (speedMeterPerSecond <= 0.0f) {
        self.speedMeterPerSecond = 0.0f;
        self.speedKmPerHour = 0.0f;
        self.tempoKm = 0.0f;
        self.tempoMile = 0.0f;
    } else {
        self.speedMeterPerSecond = speedMeterPerSecond;
        self.speedKmPerHour = speedMeterPerSecond * 3.6;
        self.tempoKm = [self convertToTempo:speedMeterPerSecond unit:@"km"];
        self.tempoMile = [self convertToTempo:speedMeterPerSecond unit:@"mile"];
    }
    
}

-(NSString *)stringFromTempo:(double)tempo {
    float minutes = floor(tempo/60);
    float seconds = round(tempo - minutes * 60);
    return [NSString stringWithFormat:@"%.0f.%.0f", minutes, seconds];
}

-(double)convertToTempo:(double)speed unit:(NSString *)unit {
    /* Convert from m/s to s/km ...... 1/((km/1000)/s) */
    NSTimeInterval tempo; // min / km = 1/(((m/s)*3.6)/60)
    
    if ([unit isEqualToString:@"km"]) {
        tempo = 1/(speed/1000);
        NSLog(@"\n Tempo: %.6f", tempo);
    }
    
    else if ([unit isEqualToString:@"mile"]) {
        double mile = 1.609344 * 1000;
        tempo = 1/(speed/mile);
    }
    else {
        NSLog(@"Unknown format: %@,. Need to be \"km\" or \"mile\".", unit);
        return 0;
    }
    return tempo;
}

@end
