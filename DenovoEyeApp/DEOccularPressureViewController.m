//
//  DEOccularPressureViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 19/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEOccularPressureViewController.h"
#import "DEOCPDetailCell.h"

@interface DEOccularPressureViewController ()

@end

@implementation DEOccularPressureViewController

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
	// Do any additional setup after loading the view.
}


-(ASValueTrackingSlider * ) getTrackerView:(int)currentPosition{
    ASValueTrackingSlider *trackerView = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(20, 0, 200, 50)];
    trackerView.minimumValue = 0;
    trackerView.maximumValue = 40;
    trackerView.value=25;
    trackerView.thumbTintColor=[UIColor blueColor];
    return trackerView;
}


#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DEOCPDetailCell *cell = (DEOCPDetailCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(indexPath.row == 0)
        cell.eyeDexterity.text = @"Right";
    else
        cell.eyeDexterity.text= @"Left";
    ASValueTrackingSlider *trackerView = [self getTrackerView:50];
    [cell.ocpMeterContainer addSubview:trackerView];
    NSDate* now = [NSDate date];
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    cell.lastUpdateLabel.text = [df stringFromDate:now];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
