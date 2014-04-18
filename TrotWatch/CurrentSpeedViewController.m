//
//  ViewController.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-17.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "CurrentSpeedViewController.h"
#import "LocationHandler.h"
#import <CoreLocation/CoreLocation.h>

@interface CurrentSpeedViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *speedMeterPerSecond;
@property (strong, nonatomic) IBOutlet UILabel *speedKilometerPerHour;
@property (strong, nonatomic) IBOutlet UILabel *tempoLabel;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) LocationHandler *locationHandler;

@end

@implementation CurrentSpeedViewController {
    CLLocationManager *manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationHandler = [[LocationHandler alloc] init];
    
	manager = [[CLLocationManager alloc] init];

}
- (IBAction)startPressed:(UIButton *)sender {
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [manager startUpdatingLocation];
    [_locationHandler startUpdatingLocation];
    [self switchButtonToStop];
 }
- (IBAction)stopPressed:(id)sender {
    [manager stopUpdatingLocation];
    [_locationHandler stopUpdatingLocation];
    [self switchButtonToStart];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Update UI elements

-(void)switchButtonToStop {
    self.stopButton.hidden = false;
    self.stopButton.enabled = true;
    
    self.startButton.hidden = true;
    self.startButton.enabled = false;
}

-(void)switchButtonToStart {
    self.stopButton.hidden = true;
    self.stopButton.enabled = false;
    
    self.startButton.hidden = false;
    self.startButton.enabled = true;
}

-(void)setTempoTo:(double)tempo {
    self.tempoLabel.text = [self stringFromTempo:tempo];
}

-(void)setSpeedMeterPerSecondTo:(double)speed {
    self.speedMeterPerSecond.text =[NSString stringWithFormat:@"%2.2f", speed];
}

-(void)setSpeedKilometerPerHourTo:(double)speed {
    self.speedKilometerPerHour.text =[NSString stringWithFormat:@"%2.1f", speed];
}

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)themanager didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location.");
    [manager stopUpdatingLocation];
    [self switchButtonToStart];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    self.stopButton.hidden = false;
//    self.startButton.hidden = true;
    
    NSLog(@"New location: %@", [locations lastObject]);
    
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation) {
        
        CLLocationSpeed currentSpeed = currentLocation.speed;
        CLLocationSpeed currentSpeedKmph = currentSpeed * 3.6;
        CLLocationSpeed tempo = [self convertToTempo:currentSpeed];
        
        [self setSpeedMeterPerSecondTo:currentSpeed];
        [self setSpeedKilometerPerHourTo:currentSpeedKmph];
        [self setTempoTo:tempo];

    }
}

-(NSString *)stringFromTempo:(double)tempo {
    float minutes = floor(tempo/60);
    float seconds = round(tempo - minutes * 60);
    return [NSString stringWithFormat:@"%.0f.%02.0f", minutes, seconds];
}

-(CLLocationSpeed)convertToTempo:(CLLocationSpeed)speed {
    /* Convert from m/s to s/km ...... 1/((km/1000)/s) */
    NSTimeInterval tempo; // min / km = 1/(((m/s)*3.6)/60)
    tempo = 1/(speed/1000);
    NSLog(@"\n Tempo: %.6f", tempo);

    return tempo;
}

@end
