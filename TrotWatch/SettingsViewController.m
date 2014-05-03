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
    
    self.optionsTableView.backgroundColor = [UIColor clearColor];
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
    
    static NSString *Identifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    if (cell) {
        return cell;
    }
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    
    cell.frame = CGRectMake(0, 0, tableView.frame.size.width, cell.frame.size.height);
    cell.backgroundColor = [UIColor clearColor];
    
    //Setup treshold
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Treshold";
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIButton *tresholdButton = [[UIButton alloc] initWithFrame:CGRectMake(cell.frame.size.width - 50, cell.frame.size.height/2, 30, 30)];
        tresholdButton.backgroundColor = [UIColor redColor];
        [cell addSubview:tresholdButton];
        
    }
    return cell;
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
