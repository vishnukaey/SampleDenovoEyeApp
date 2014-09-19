//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.

#import "DEReminderViewController.h"
#import "DEAppoinmentViewController.h"
#import "DEAppointmentTableCell.h"

@interface DEReminderViewController (){
    NSMutableArray *hour,*minutes,*meridian;
    UIDatePicker *timePicker;
    UITextField *activeField;

}

@end

@implementation DEReminderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


- (void)viewDidLoad{
    [super viewDidLoad];
    self.medication.reminder=[[NSMutableArray alloc] init];
    timePicker = [[UIDatePicker alloc]init];
    timePicker.datePickerMode=UIDatePickerModeTime;
    
    [timePicker addTarget:self
                action:@selector(timePickerValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    timePicker.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    for(int i=0 ; i < [self.medication.frequency intValue];i++){
        [self.medication.reminder addObject:@""];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField=textField;
}


#pragma - mark Other Functions

- (IBAction)next:(id)sender {
    [self performSegueWithIdentifier:@"appoinment" sender:self];
    NSLog(@"%@",self.medication.reminder);
}


-(NSString *)getTimeStringFromDate :(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"hh:mm a"];
    NSString *timeString = [dateFormatter stringFromDate:date];
    return timeString;
}


-(void) timePickerValueChanged:(id) sender{
    NSDate *date= timePicker.date;
    activeField.text=[self getTimeStringFromDate:date];
    [self.medication.reminder setObject:activeField.text atIndexedSubscript:activeField.tag];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"appoinment"]){
        DEAppoinmentViewController *appointment=[segue destinationViewController];
        appointment.medication=self.medication;
    }
}


#pragma -mark TableView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
        return 1;
    else
        return [self.medication.frequency intValue];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        static NSString *CellIdentifier = @"reminder";
        UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textLabel.text=[NSString stringWithFormat:@"%@x %@",self.medication.frequency,self.medication.reccurence];
        cell.textLabel.textColor=[UIColor lightGrayColor];
        cell.textLabel.font=[cell.textLabel.font fontWithSize:25];
        return cell;
    }
    
    else{
        static NSString *CellIdentifier = @"reminder1";
        DEAppointmentTableCell *cell =(DEAppointmentTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.textField.font=[cell.textField.font fontWithSize:25];
        cell.textField.tintColor=[UIColor colorWithRed:29 green:152 blue:167 alpha:1];
        cell.textField.tag=indexPath.row;
        cell.textField.inputView=timePicker;
        return cell;
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"FREQUENCY";
    if (section == 1)
        return @"SET REMINDERS AT";
    return @"undefined";
}


@end

