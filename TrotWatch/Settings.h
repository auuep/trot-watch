//
//  Settings.h
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-21.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

- (NSArray *)getLowerAndUpperTreshold;
- (void) updateLowerTreshold:(double)treshold;
- (void) updateUpperTreshold:(double)treshold;
- (NSArray *)allowedLowerTresholdValues;
- (NSArray *)allowedUpperTresholdValues;
- (NSString *)getLowerTreshold;
- (NSString *)getUpperTreshold;
- (NSString *)getMeasurementSystem;


+ (id)sharedModel;

@end
