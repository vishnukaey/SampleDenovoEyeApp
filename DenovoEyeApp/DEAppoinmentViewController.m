//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEAppoinmentViewController.h"
#import "DEConfirmationViewController.h"
#import "DEAppointmentTableCell.h"

@interface DEAppoinmentViewController (){
    NSMutableArray *appoinmentArray;
    UIDatePicker *datePicker,*timePicker;
    UITextField *activeField;
}

@end

@implementation DEAppoinmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad{
    [super viewDidLoad];
    appoinmentArray=[[NSMutableArray alloc]initWithObjects:@"Provider or Doctor",@"Date of Appointment",@"Time of Appointment", nil];
    [self createADateAPicker];
    self.medication.appointment=[[NSMutableArray alloc]init];
}

- (IBAction)skipToConfirm:(id)sender {
    NSLog(@"Appoinment: %@",self.medication.appointment);
    [self performSegueWithIdentifier:@"confirm" sender:self];
}


#pragma -mark Picker Datasource and Delegates
-(void) createADateAPicker{
    datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
    timePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
     timePicker.backgroundColor=[UIColor groupTableViewBackgroundColor];
     datePicker.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [datePicker addTarget:self
                action:@selector(datePickerValueChanged:)
                forControlEvents:UIControlEventValueChanged];
    [timePicker addTarget:self
                action:@selector(timePickerValueChanged:)
                forControlEvents:UIControlEventValueChanged];
}


-(void) datePickerValueChanged:(id) sender{
    NSDate *date= datePicker.date;
    activeField.text=[self getDateStringFromDate:date];
    [self.medication.appointment setObject:activeField.text atIndexedSubscript:activeField.tag];
}


-(NSString *)getDateStringFromDate :(NSDate *)date {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd-MMM-YYYY"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
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
    [self.medication.appointment setObject:activeField.text atIndexedSubscript:activeField.tag];
}


#pragma -mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"appointmentCell";
    DEAppointmentTableCell *cell =(DEAppointmentTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textField.placeholder=[appoinmentArray objectAtIndex:indexPath.row];
    cell.textField.tag=indexPath.row;
    
    if(indexPath.row == 1){
        datePicker.datePickerMode = UIDatePickerModeDate;
        cell.textField.inputView=datePicker;
    }
    if (indexPath.row == 2) {
        timePicker.datePickerMode=UIDatePickerModeTime;
        cell.textField.inputView=timePicker;
    }
    [self.medication.appointment addObject:cell.textField.text];
    cell.textField.tag=indexPath.row;
   
    return cell;
}



#pragma -mark TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField=textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(activeField.tag==0)
    [self.medication.appointment setObject:activeField.text atIndexedSubscript:activeField.tag];
}


-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"confirm"]){
        DEConfirmationViewController *confirm=[segue destinationViewController];
        confirm.medication=self.medication;
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}


@end
