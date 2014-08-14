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
    NSMutableDictionary *appointmentDict;
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
    appointmentDict =[[ NSMutableDictionary alloc]init];
    [self createADateAPicker];
}

- (IBAction)skipToConfirm:(id)sender {
    DEDataHandler *handler=[[DEDataHandler alloc] init];
    [handler saveAppointment:appointmentDict];
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
    [appointmentDict setValue:activeField.text forKey:@"date"];
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
    [appointmentDict setValue:activeField.text forKey:@"time"];
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
    cell.textField.tag=indexPath.row;
   
    return cell;
}



#pragma -mark TextField Delegates

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField=textField;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    if(activeField.tag==0)
        [appointmentDict setValue:activeField.text forKey:@"provider"];
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
