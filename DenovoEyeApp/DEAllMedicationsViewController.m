//
//  DEAllMedicationsViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 18/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEAllMedicationsViewController.h"
#import "DEMedicationCell.h"
#import "LEColorPicker.h"
#import "DEConfirmationViewController.h"

@interface DEAllMedicationsViewController (){
    NSArray *myMedicationList;
    ParseMedicationDBModal *medication;
}

@end

@implementation DEAllMedicationsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DEDataHandler *handler=[[DEDataHandler alloc]init];
    myMedicationList=[handler getMedicationList];
    [self.tableView reloadData];
}

- (IBAction)addMedication:(id)sender {
    [self performSegueWithIdentifier:@"add" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return myMedicationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"medication";
    DEMedicationCell *cell = (DEMedicationCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *name=[[myMedicationList objectAtIndex:indexPath.row] valueForKey:@"drugName"];
    cell.drugName.text=[NSString stringWithFormat:@"\t%@",name];
    cell.drugImage.image=[UIImage imageWithData:[[myMedicationList objectAtIndex:indexPath.row] valueForKey:@"drugImage"]];
    LEColorPicker *colorPicker = [[LEColorPicker alloc] init];
    LEColorScheme *colorScheme = [colorPicker colorSchemeFromImage:cell.drugImage.image];
    cell.drugName.backgroundColor = [colorScheme primaryTextColor];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header= [[NSString alloc] init];
    header=[NSString stringWithFormat:@"%lu Medications",(unsigned long)myMedicationList.count];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self prepareSelectedObject:indexPath.row];
    [self performSegueWithIdentifier:@"reconfirm" sender:self];
    
}

-(void) prepareSelectedObject:(NSInteger)row{
    medication = [[ParseMedicationDBModal alloc] init];
    medication.drugName=[[myMedicationList objectAtIndex:row] valueForKey:@"drugName"];
    medication.drugImageData=[[myMedicationList objectAtIndex:row] valueForKey:@"drugImage"];
    medication.frequency=[[myMedicationList objectAtIndex:row] valueForKey:@"frequency"];
    medication.reccurence=[[myMedicationList objectAtIndex:row] valueForKey:@"reccurence"];
    medication.reminder=[[myMedicationList objectAtIndex:row] valueForKey:@"reminder"];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"reconfirm"]){
        DEConfirmationViewController *reconfirm=[segue destinationViewController];
        reconfirm.medication=medication;
    }
}


@end
