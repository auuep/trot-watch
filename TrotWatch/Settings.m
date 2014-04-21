//
//  Settings.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-21.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "Settings.h"

@interface Settings ()

@property (strong, nonatomic) NSMutableDictionary *speedTreshold;

@end

@implementation Settings

- (id)init
{
    self = [super init];
    
    _speedTreshold = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0.0", @"lowerTreshold", @"0.0", @"upperTreshold", nil];
    
    return self;
}

- (NSString *)getLowerAndUpperTreshold {
    NSString *treshold = [_speedTreshold objectForKey:@"lowerTreshold"];
   // NSLog(@"Got values. Lower = %@   Upper = %@", treshold[0], treshold[1]);
    NSArray *tresholds = [_speedTreshold objectsForKeys:[NSArray arrayWithObjects:@"lowerTreshold", @"upperTreshold" , nil] notFoundMarker:@"0.0"];
    NSLog(@"Got tresholds. Lower = %@   Upper = %@", tresholds[0], tresholds[1]);

    return treshold;
}

- (void) updateLowerTreshold:(double)treshold {
    [_speedTreshold setValue:[NSString stringWithFormat:@"%f",treshold] forKey:@"lowerTreshold"];
    NSLog(@"Updated lower treshold to: %f", treshold);
}

- (void) updateUpperTreshold:(double)treshold {
    [_speedTreshold setValue:[NSString stringWithFormat:@"%f",treshold] forKey:@"upperTreshold"];
    NSLog(@"Updated upper treshold to: %f", treshold);
}

@end
