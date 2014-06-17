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
    
    _speedTreshold = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"-5", @"lowerTreshold", @"5", @"upperTreshold", nil];
    
    return self;
}

- (NSString *)getMeasurementSystem
{   
    NSLocale *locale = [NSLocale currentLocale];
    
    NSString *measurementSystem = [locale objectForKey:NSLocaleMeasurementSystem];
    return measurementSystem;
}

- (NSArray *)getLowerAndUpperTreshold {
    NSArray *tresholds = [_speedTreshold objectsForKeys:[NSArray arrayWithObjects:@"lowerTreshold", @"upperTreshold" , nil] notFoundMarker:@"0"];
    return tresholds;
}

- (NSString *)getLowerTreshold {
    return [_speedTreshold objectForKey:@"lowerTreshold"];
}

- (NSString *)getUpperTreshold {
    return [_speedTreshold objectForKey:@"upperTreshold"];
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

- (NSArray *)allowedUpperTresholdValues
{
    return [NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
}



#pragma mark - App settings
- (BOOL)enableExtraLabels {
    return NO;
}


@end
