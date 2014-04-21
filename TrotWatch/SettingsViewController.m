//
//  SettingsViewController.m
//  TrotWatch
//
//  Created by Daniel Andersson on 2014-04-19.
//  Copyright (c) 2014 Daniel P Andersson. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *optionsTableView;
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
    self.settings = [[Settings alloc] init];
    self.settingsTypes = [NSArray arrayWithObjects:@"Treshold", @"MilesOrKm", @"Harr", nil];
    
    [self testSettings];
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

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsTypes.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView.frame.size.height / self.settingsTypes.count;
    //return [self tableView:tableView cellForRowAtIndexPath:indexPath].frame.size.height;
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
