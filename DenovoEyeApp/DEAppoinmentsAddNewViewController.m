//
//  DEAppoinmentsAddNewViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 14/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEAppoinmentsAddNewViewController.h"

@interface DEAppoinmentsAddNewViewController (){
    NSMutableArray *appoinmentArray;
    NSMutableDictionary *appointmentDict;
    UIDatePicker *datePicker,*timePicker;
    UITextField *activeField;
}

@end

@implementation DEAppoinmentsAddNewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


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
    self.date.inputView=datePicker;
    self.time.inputView=timePicker;
}


-(void) datePickerValueChanged:(id) sender{
    NSDate *date= datePicker.date;
    activeField.text=[self getDateStringFromDate:date];
    [appointmentDict setValue:activeField.text forKey:@"date"];
}

- (IBAction)doneAddingAppointment:(id)sender {
    DEDataHandler *handler =[[DEDataHandler alloc]init];
    [handler saveAppointment:appointmentDict];
    [Utilities showAlert:@"Successfully added" withTitle:@"Success"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField=textField;
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



- (void)viewDidLoad
{
    [super viewDidLoad];
	[self createADateAPicker];
    self.physicianName.text = self.physician;
    timePicker.datePickerMode=UIDatePickerModeTime;
    datePicker.datePickerMode=UIDatePickerModeDate;
    appointmentDict = [[NSMutableDictionary alloc]init];
    [appointmentDict setValue:self.physician forKey:@"provider"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
