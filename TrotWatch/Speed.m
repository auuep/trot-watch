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
    return [self initWithSpeedMS:0];
}


-(NSString *)stringFromTempo:(double)tempo {
    float minutes = floor(tempo/60);
    float seconds = round(tempo - minutes * 60);
    return [NSString stringWithFormat:@"%.0f.%.0f", minutes, seconds];
}

-(double)convertToTempo:(double)speed {
    /* Convert from m/s to s/km ...... 1/((km/1000)/s) */
    NSTimeInterval tempo; // min / km = 1/(((m/s)*3.6)/60)
    tempo = 1/(speed/1000);
    NSLog(@"\n Tempo: %.6f", tempo);
    
    return tempo;
}

@end
