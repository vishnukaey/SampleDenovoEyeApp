//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEReccurenceViewController.h"
#import "DEReminderViewController.h"

@interface DEReccurenceViewController (){
    NSMutableArray *frequency;
    NSArray *reccur;
}

@end

@implementation DEReccurenceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    frequency = [[NSMutableArray alloc]init];
    for (int i=0;i<10;i++){
        [frequency  setObject:@(i+1) atIndexedSubscript:i];
    }
    reccur=[[NSArray alloc]initWithObjects:@"Daily",@"Weekly",@"Monthly",nil];
    
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One column
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //set number of rows
    if(component == 0)
        return [frequency count];
    else
        return [reccur count];
}

- (IBAction)nextViewController:(id)sender {
    self.medication.frequency=self.frequencyLabel.text;
    self.medication.reccurence=self.recurrenceLabel.text;
    [self performSegueWithIdentifier:@"reminder" sender:self];
}

- (IBAction)setCustomFrequency:(id)sender {
    NSLog(@"Set Custom frequency");
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
        return [NSString stringWithFormat:@"%@",[frequency objectAtIndex:row]];
    else
        return [reccur objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{   
    if(component == 0)
        self.frequencyLabel.text=[NSString stringWithFormat:@"%@",[frequency objectAtIndex:row]];
    else
        self.recurrenceLabel.text=[reccur objectAtIndex:row];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"reminder"]){
        DEReminderViewController *remind=[segue destinationViewController];
        remind.medication=self.medication;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
