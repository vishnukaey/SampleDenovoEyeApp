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

@interface DEAppoinmentViewController () <MDCalendarDelegate>{
    NSMutableArray *appoinmentArray;
    UIDatePicker *datePicker,*timePicker;
    UITextField *activeField;
    NSMutableDictionary *appointmentDict;
    UIView *calenderAccessoryView;
}

@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, assign) NSDate *firstDayOfStartMonth;
@property (nonatomic, strong) MDCalendar *calendarView;

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
    self.calendarView = [self createACalenderView:[NSDate date]];
//    [self createCalenderAccessoryView];
}

- (IBAction)skipToConfirm:(id)sender {
    DEDataHandler *handler=[[DEDataHandler alloc] init];
    [handler saveAppointment:appointmentDict];
    [self performSegueWithIdentifier:@"confirm" sender:self];
}


#pragma -mark Picker Datasource and Delegates
-(void) createADateAPicker{
    timePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
     timePicker.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [timePicker addTarget:self
                action:@selector(timePickerValueChanged:)
                forControlEvents:UIControlEventValueChanged];
}

-(MDCalendar * ) createACalenderView: (NSDate *) startDate{
    MDCalendar *calendarView = [[MDCalendar alloc] init];
    calendarView.backgroundColor = [UIColor whiteColor];
    calendarView.lineSpacing = 0.f;
    calendarView.itemSpacing = 0.0f;
    calendarView.borderColor = [UIColor lightGrayColor];
    calendarView.borderHeight = .5f;
    calendarView.showsBottomSectionBorder = YES;
    
    calendarView.textColor = [UIColor lightGrayColor];
    calendarView.headerTextColor = [UIColor lightGrayColor];
    calendarView.weekdayTextColor = [UIColor grayColor];
    calendarView.cellBackgroundColor = [UIColor whiteColor];
    
    calendarView.highlightColor = [UIColor darkGrayColor];
    calendarView.indicatorColor = [UIColor colorWithWhite:0.85 alpha:.8];
    NSDate *endDate = [startDate dateByAddingMonths:0];
    calendarView.startDate = startDate;
    calendarView.endDate = endDate;
    calendarView.delegate = self;
    calendarView.canSelectDaysBeforeStartDate = YES;
    return calendarView;
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



-(void)calendarView:(MDCalendar *)calendarView didSelectDate:(NSDate *)date{
    activeField.text = [self getDateStringFromDate:date];
}



- (BOOL) calendarView:(MDCalendar *)calendarView shouldShowIndicatorForDate:(NSDate *)date
{
    return [date day] % 4 == 1;
}



- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}



#pragma -mark TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    calenderAccessoryView.frame =  CGRectMake(0, 0, 320, 20);
    _calendarView.frame = CGRectMake(0, 0, 320, 355);
    _calendarView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"appointmentCell";
    DEAppointmentTableCell *cell =(DEAppointmentTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textField.placeholder=[appoinmentArray objectAtIndex:indexPath.row];
    cell.textField.tag=indexPath.row;
    
    if(indexPath.row == 1){
        datePicker.datePickerMode = UIDatePickerModeDate;
        cell.textField.inputView=_calendarView;
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
