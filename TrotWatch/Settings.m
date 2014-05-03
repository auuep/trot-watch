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

+ (id)sharedModel
{
    static Settings *sharedSettings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSettings = [[self alloc] init];
    });
    return sharedSettings;
}

- (id)init
{
    self = [super init];
    
    _speedTreshold = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0.0", @"lowerTreshold", @"0.0", @"upperTreshold", nil];
    
    return self;
}

- (NSArray *)getLowerAndUpperTreshold {
    NSArray *tresholds = [_speedTreshold objectsForKeys:[NSArray arrayWithObjects:@"lowerTreshold", @"upperTreshold" , nil] notFoundMarker:@"0.0"];
    return tresholds;
}

- (void) updateLowerTreshold:(double)treshold {
    [_speedTreshold setValue:[NSString stringWithFormat:@"%.0f",treshold] forKey:@"lowerTreshold"];
    NSLog(@"Updated lower treshold to: %f", treshold);
}

- (void) updateUpperTreshold:(double)treshold {
    [_speedTreshold setValue:[NSString stringWithFormat:@"%.0f",treshold] forKey:@"upperTreshold"];
}

- (NSArray *)allowedLowerTresholdValues
{
    return [NSArray arrayWithObjects:@"-10",@"-9",@"-8",@"-7",@"-6",@"-5",@"-4",@"-3",@"-2",@"-1",@"0", nil];
}


@end
