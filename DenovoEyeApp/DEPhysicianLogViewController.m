//
//  DEPhysicianLogViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEPhysicianLogViewController.h"
#import "DEAppoinmentsAddNewViewController.h"

@interface DEPhysicianLogViewController (){
    NSArray *allAppoinments;
    NSMutableArray *AppoinmentsWithAPhysician;
}

@end

@implementation DEPhysicianLogViewController

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
    self.photo.layer.cornerRadius = self.photo.frame.size.height / 2;
    self.photo.clipsToBounds = YES;
	self.photo.image=[UIImage imageWithData:[self.physician.photo getData]];
    self.physicianName.text=self.physician.name;
    AppoinmentsWithAPhysician = [[NSMutableArray alloc] init];
    DEDataHandler *handler =[[DEDataHandler alloc]init];
    allAppoinments = [handler getAllAppoinments];
    NSLog(@"Appointments are %@",allAppoinments);
    for(int i = 0; i< allAppoinments.count;i++){
        if([[[allAppoinments objectAtIndex:i] valueForKey:@"provider"] isEqualToString:self.physicianName.text])
        [AppoinmentsWithAPhysician addObject:[allAppoinments objectAtIndex:i]];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return AppoinmentsWithAPhysician.count;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header= [[NSString alloc] init];
    header = @"Appoinment History";
    return header;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text=[[AppoinmentsWithAPhysician objectAtIndex:indexPath.row] valueForKey:@"date"];
    return cell;
}


- (IBAction)makeNewAppoinment:(id)sender {
    [self performSegueWithIdentifier:@"addNew" sender:self];
}



-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DEAppoinmentsAddNewViewController *add=[segue destinationViewController];
    add.physician = self.physicianName.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
