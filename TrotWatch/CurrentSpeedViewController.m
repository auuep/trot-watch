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
#import "Settings.h"

@interface CurrentSpeedViewController () <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *speedMeterPerSecond;
@property (strong, nonatomic) IBOutlet UILabel *speedKilometerPerHour;
@property (strong, nonatomic) IBOutlet UILabel *tempoLabel;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) LocationHandler *locationHandler;
@property (strong, nonatomic) IBOutlet UILabel *tempoDescription;
@property (strong, nonatomic) IBOutlet UILabel *speedMeterPerSecondDescription;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tempoCenterConstraint;

@end

@implementation CurrentSpeedViewController {

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.locationHandler = [[LocationHandler alloc] init];
    [_locationHandler addObserver:self forKeyPath:@"isUpdating" options:NSKeyValueObservingOptionNew context:nil];
    [_locationHandler addObserver:self forKeyPath:@"currentSpeed.speedMeterPerSecond" options:NSKeyValueObservingOptionNew context:nil];

    if (![[Settings sharedModel] enableExtraLabels]) {
        [self hideSpeedMS];
        [self hideTempoDescription];        
    }

}
- (IBAction)startPressed:(UIButton *)sender {
    [_locationHandler startUpdatingLocation];
    [self switchButtonToStop];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
 }
- (IBAction)stopPressed:(id)sender {

    [_locationHandler stopUpdatingLocation];
    [self switchButtonToStart];
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (IBAction)settingsPressed:(UIButton *)sender {
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
    
    self.tempoLabel.textColor = [UIColor blackColor];
}

-(void)switchButtonToStart {
    self.stopButton.hidden = true;
    self.stopButton.enabled = false;
    
    self.startButton.hidden = false;
    self.startButton.enabled = true;
    
    self.tempoLabel.textColor = [UIColor lightGrayColor];

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

-(NSString *)stringFromTempo:(double)tempo {
    float minutes = floor(tempo/60);
    float seconds = tempo - minutes * 60;
    return [NSString stringWithFormat:@"%.0f.%.2f", minutes, seconds];
}

-(void)hideSpeedMS {
    _speedMeterPerSecond.hidden = YES;
    _speedMeterPerSecondDescription.hidden = YES;
}

-(void)hideTempoDescription {
    _tempoDescription.hidden = YES;
    self.tempoCenterConstraint.constant = 0;
}

#pragma mark Key Value Observations

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"isUpdating"]) {
        if ([_locationHandler isUpdating]) {
            [self switchButtonToStop];
        } else {
            [self switchButtonToStart];
        }
    }
    else if ([keyPath isEqualToString:@"currentSpeed.speedMeterPerSecond"]) {
        [self setSpeedMeterPerSecondTo:_locationHandler.currentSpeed.speedMeterPerSecond];
        [self setSpeedKilometerPerHourTo:_locationHandler.currentSpeed.speedKmPerHour];
        [self setTempoTo:_locationHandler.currentSpeed.tempoKm];
    }
   
}

@end
