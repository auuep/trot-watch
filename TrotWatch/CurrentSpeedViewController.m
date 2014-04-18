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
@property (strong, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *speedMeterPerSecond;
@property (strong, nonatomic) IBOutlet UILabel *speedKilometerPerHour;
@property (strong, nonatomic) IBOutlet UILabel *tempoLabel;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) LocationHandler *locationHandler;

@end

@implementation CurrentSpeedViewController {
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationHandler = [[LocationHandler alloc] init];
    
	manager = [[CLLocationManager alloc] init];
    
    geocoder = [[CLGeocoder alloc] init];
    
}
- (IBAction)startPressed:(UIButton *)sender {
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [manager startUpdatingLocation];
//    self.stopButton.hidden = false;
//    self.startButton.hidden = true;
}
- (IBAction)stopPressed:(id)sender {
    [manager stopUpdatingLocation];
    self.stopButton.hidden = true;
    self.startButton.hidden = false;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location.");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.stopButton.hidden = false;
    self.startButton.hidden = true;
    
    NSLog(@"New location: %@", [locations lastObject]);
    
    CLLocation *currentLocation = [locations lastObject];
    
    if (currentLocation) {
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.latitude];
        self.longitudeLabel.text = [NSString stringWithFormat:@"%.2f", currentLocation.coordinate.longitude];
        
        CLLocationSpeed currentSpeed = currentLocation.speed;
        CLLocationSpeed currentSpeedKmph = currentSpeed * 3.6;
        CLLocationSpeed tempo = [self convertToTempo:currentSpeed];
        
        self.speedMeterPerSecond.text = [NSString stringWithFormat:@"%.1f", currentSpeed];
        self.speedKilometerPerHour.text =[NSString stringWithFormat:@"%.1f", currentSpeedKmph];
        self.tempoLabel.text = [self stringFromTempo:tempo];
    }
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            placemark = [placemarks lastObject];
            
            self.addressLabel.text = [NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                                      placemark.subThoroughfare, placemark.thoroughfare, placemark.postalCode, placemark.locality, placemark.administrativeArea, placemark.country];
        }
        else {
            NSLog(@"Error: %@", error);
        }
    }];
    
}

-(NSString *)stringFromTempo:(CLLocationSpeed)tempo {
    float minutes = floor(tempo/60);
    float seconds = round(tempo - minutes * 60);
    return [NSString stringWithFormat:@"%.0f.%.0f", minutes, seconds];
}

-(CLLocationSpeed)convertToTempo:(CLLocationSpeed)speed {
    /* Convert from m/s to s/km ...... 1/((km/1000)/s) */
    NSTimeInterval tempo; // min / km = 1/(((m/s)*3.6)/60)
    tempo = 1/(speed/1000);
    NSLog(@"\n Tempo: %.6f", tempo);

    return tempo;
}

@end
