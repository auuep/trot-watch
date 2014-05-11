//
//  TWPickerViewController.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-05-12.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "TWPickerViewController.h"

@interface TWPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *itemsInPicker; //For example ["1", "2", "3"];
@end

@implementation TWPickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithComponents:(NSArray *)components withSelectedRowPerComponent:(NSArray *)rows
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)drawPicker
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width, self.view.frame.size.height, 216)];
    self.pickerView.backgroundColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.95f];
    self.pickerView.alpha = 0;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 0;
            break;
        case 1:
            return 0;
            break;
        default:
            return 0;
            break;
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        default:
            return @"";
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat sectionWidth = self.view.frame.size.width/2;
    
    return sectionWidth;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
//            [self.settings updateLowerTreshold:[self.settings.allowedLowerTresholdValues[row] doubleValue]];
            break;
        case 1:
//            [self.settings updateUpperTreshold:[self.settings.allowedUpperTresholdValues[row] doubleValue]];
        default:
            break;
    }
    
    //Close picker
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 216);
    self.pickerView.transform = transfrom;
    self.pickerView.alpha = 0;
    [UIView commitAnimations];
    
}



@end
