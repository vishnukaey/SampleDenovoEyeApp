


//
//  DEAppointmentsAppointmentViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEAppointmentsAppointmentViewController.h"
#import "DEPhysicianTableCell.h"
#import "DEPhysicianLogViewController.h"

@interface DEAppointmentsAppointmentViewController (){
    NSArray *physicians;
    NSInteger cellAtIndex;
}

@end

@implementation DEAppointmentsAppointmentViewController

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
    [self getPhysiciansList:@""];
    DEDataHandler *handler =[[DEDataHandler alloc]init];
    NSArray *hello= [handler getAllAppoinments];
    NSLog(@"Appointments are %@",hello);
}

-(void) getPhysiciansList:(NSString *) queryString{
    PFQuery *query=[DEParsePhysicianModel query];
    if(![queryString isEqualToString:@""])
        [query whereKey:@"name" containsString:[queryString capitalizedString]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        physicians = [objects mutableCopy];
        [self.physicianTable reloadData];
    }];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return physicians.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"physician";
     DEPhysicianTableCell *cell =(DEPhysicianTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    DEParsePhysicianModel *physician=[physicians objectAtIndex:indexPath.row];
    cell.physicianName.text=physician.name;
    cell.physicianAddress.text=physician.address;
    cell.physicianSpecialisation.text=physician.specialisation;
    cell.physicianImage.image=[UIImage imageWithData:[physician.photo getData]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    cellAtIndex=indexPath.row;
    [self performSegueWithIdentifier:@"appoint" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"appoint"]){
        DEPhysicianLogViewController *log=[segue destinationViewController];
        log.physician=[physicians objectAtIndex:cellAtIndex];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"Text did change :)");
    [self getPhysiciansList:searchText];
    [self.physicianTable reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
