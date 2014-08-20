//
//  DESampleViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 20/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DESampleViewController.h"

@interface DESampleViewController () <MDCalendarDelegate>
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, assign) NSDate *firstDayOfStartMonth;
@property (nonatomic, strong) MDCalendar *calendarView;
@end

@implementation DESampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    MDCalendar *calendarView = [[MDCalendar alloc] init];
    calendarView.backgroundColor = [UIColor whiteColor];
    
    calendarView.lineSpacing = 0.f;
    calendarView.itemSpacing = 0.0f;
    calendarView.borderColor = [UIColor lightGrayColor];
    calendarView.borderHeight = 1.f;
    calendarView.showsBottomSectionBorder = YES;
    
    calendarView.textColor = [UIColor lightGrayColor];
    calendarView.headerTextColor = [UIColor lightGrayColor];
    calendarView.weekdayTextColor = [UIColor grayColor];
    calendarView.cellBackgroundColor = [UIColor whiteColor];
    
    calendarView.highlightColor = [UIColor darkGrayColor];
    calendarView.indicatorColor = [UIColor colorWithWhite:0.85 alpha:1.0];
    
    NSDate *startDate = [NSDate date];
    NSDate *endDate = [startDate dateByAddingMonths:0];
    
    calendarView.startDate = startDate;
    calendarView.endDate = endDate;
    calendarView.delegate = self;
    calendarView.canSelectDaysBeforeStartDate = YES;
    self.calendarView = calendarView;
    self.textField.inputView = _calendarView;
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _calendarView.frame = CGRectMake(0, 0, 320, 352);
    _calendarView.contentInset = UIEdgeInsetsMake([self.topLayoutGuide length], 0, [self.bottomLayoutGuide length], 0);
}

#pragma mark - MDCalendarViewDelegate

- (void)calendarView:(MDCalendar *)calendarView didSelectDate:(NSDate *)date{
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
   // [df setDateStyle:NSDateFormatterShortStyle];
    self.textField.text = [df stringFromDate:date];
    NSLog(@"Selected Date: %@", [date descriptionWithLocale:[NSLocale currentLocale]]);
}

- (BOOL) calendarView:(MDCalendar *)calendarView shouldShowIndicatorForDate:(NSDate *)date
{
    // show indicator for every 4th day
    return [date day] % 4 == 1;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self view] endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
