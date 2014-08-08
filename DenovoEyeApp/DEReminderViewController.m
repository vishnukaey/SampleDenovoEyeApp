//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.

#import "DEReminderViewController.h"

@interface DEReminderViewController (){
    NSMutableArray *hour,*minutes,*meridian;
    UIPickerView *myPickerView ;
}

@end

@implementation DEReminderViewController

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
    NSLog(@"%@",self.medication);
    myPickerView=[[UIPickerView alloc] initWithFrame:CGRectMake(0, 300, 320, 200)];
    myPickerView.delegate = self;
    myPickerView.showsSelectionIndicator = YES;
    myPickerView.backgroundColor=[UIColor lightGrayColor];
    [self setDataSource];
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                      style:UIBarButtonItemStyleBordered target:self action:@selector(finishedSettingDate:)];
    toolBar.items = [[NSArray alloc] initWithObjects:barButtonDone,nil];
    barButtonDone.tintColor=[UIColor blackColor];
    [myPickerView addSubview:toolBar];
}

-(void) finishedSettingDate:(id) sender{
    [myPickerView resignFirstResponder];
}

-(void) setDataSource{
    hour=[[NSMutableArray alloc]init];
    minutes=[[NSMutableArray alloc]init];
    meridian=[[NSMutableArray alloc]initWithObjects:@"AM",@"PM",Nil];
    for(int i = 0;i< 12 ; i++)
        [hour setObject:[NSString stringWithFormat:@"%d",i] atIndexedSubscript:i];
    for(int i = 0;i< 60 ; i++)
        [minutes setObject:[NSString stringWithFormat:@"%d",i] atIndexedSubscript:i];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(component == 0)
        return 12;
    else if(component == 1)
        return 60;
    else
        return 2;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}



- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(component == 0)
        return [hour objectAtIndex:row];
    else if(component == 1)
        return [minutes objectAtIndex:row];
    else
        return [meridian objectAtIndex:row];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0)
    {
        return 1;
    }
    else{
        return [self.medication.frequency intValue];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"reminder";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(indexPath.section == 0){
        cell.textLabel.text=[NSString stringWithFormat:@"%@x %@",self.medication.frequency,self.medication.reccurence];
        cell.textLabel.textColor=[UIColor lightGrayColor];
        cell.textLabel.font=[cell.textLabel.font fontWithSize:25];
    }
    else{
        cell.textLabel.textColor=[UIColor colorWithRed:29.0f/255.0f green:152.0f/255.0f blue:167.0f/255.0f alpha:1.0f];
        cell.textLabel.text=@"09:45 AM";
        cell.textLabel.font=[cell.textLabel.font fontWithSize:25];
    }
return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"FREQUENCY";
    if (section == 1)
        return @"SET REMINDERS AT";
    return @"undefined";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myPickerView becomeFirstResponder];
    [self.view addSubview:myPickerView];
    
}

-(void)tableView:(UITableView*) tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    [myPickerView removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
