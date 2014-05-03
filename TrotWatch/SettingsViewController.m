//
//  SettingsViewController.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-19.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *settingsTypes;
@property (strong, nonatomic) Settings *settings;

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.settings = [Settings sharedModel];
    self.settingsTypes = [NSArray arrayWithObjects:@"Treshold Lower", @"Treshold Upper", @"MilesOrKm", nil];
    
    //[self testSettings];
    
    self.optionsTableView.dataSource = self;
    self.optionsTableView.backgroundColor = [UIColor clearColor];

    [self addTresholdPicker];
   
}

-(void)addTresholdPicker
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width-216, self.view.frame.size.height, 216)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:self.pickerView];
}

-(void)testSettings {
    [_settings getLowerAndUpperTreshold];
    [_settings updateLowerTreshold:5.0];
    [_settings getLowerAndUpperTreshold];
    [_settings updateUpperTreshold:10.0];
    [_settings getLowerAndUpperTreshold];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI interaction

- (IBAction)closePressed:(UIButton *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)reloadTableView:(UIButton *)sender {
    NSLog(@"currenttreshold: %@", self.settings.getLowerAndUpperTreshold[0]);
    [self.optionsTableView reloadData];
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
//    if (cell) {
//        return cell;
//    }
    
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height);
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.settingsTypes[indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    //Setup tresholds
    if (indexPath.row == 0 || indexPath.row == 1) {
       
        UILabel *tresholdLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width - 50, cell.frame.size.height/2, 30, 30)];
        
        if (indexPath.row == 0) {
            tresholdLabel.text = [NSString stringWithFormat:@"%@", self.settings.getLowerAndUpperTreshold[0]];
            NSLog(@"Cell lower treshold set text");
        } else {
            tresholdLabel.text = [NSString stringWithFormat:@"%@", self.settings.getLowerAndUpperTreshold[1]];
        }
        
        tresholdLabel.backgroundColor = [UIColor clearColor];
        tresholdLabel.textColor = [UIColor whiteColor];
        [cell addSubview:tresholdLabel];
        
    }
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsTypes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.frame.size.height / self.settingsTypes.count > 44.0) {
        return tableView.frame.size.height / self.settingsTypes.count;
    }
    else {
        return 44.0;
    }
}

#pragma mark - UIPickerView

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.settings.allowedLowerTresholdValues.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.settings.allowedLowerTresholdValues[row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = self.view.frame.size.width;
    
    return sectionWidth;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.settings updateLowerTreshold:[self.settings.allowedLowerTresholdValues[row] doubleValue]];

    [UIView transitionWithView:pickerView
                      duration:0.4
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    pickerView.hidden = true;
    
    NSLog(@"Pressed: %d", row);
    [self.optionsTableView reloadData];
    NSLog(@"Number of items in tableview: %d", [self.optionsTableView numberOfRowsInSection:0]);

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
