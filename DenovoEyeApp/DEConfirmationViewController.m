//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEConfirmationViewController.h"
#import "DEDataHandler.h"
#import "DEConfirmViewCell.h"

@interface DEConfirmationViewController (){
    NSMutableArray *sectionHeaders,*medicalDetails;
}
@end

@implementation DEConfirmationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    medicalDetails=[[NSMutableArray alloc] init];
    NSMutableString *reminders=[[NSMutableString alloc] init];
    sectionHeaders =[[NSMutableArray alloc] initWithObjects:@"MEDICATION",@"FREQUENCY",@"REMINDERS AT",nil];
    [medicalDetails addObject:self.medication.drugName];
    [medicalDetails addObject:[NSString stringWithFormat:@"%@x %@",self.medication.frequency,self.medication.reccurence]];
    for(int i=0 ; i< self.medication.reminder.count;i++)
    {
        [reminders appendFormat:@"%@, ",[self.medication.reminder objectAtIndex:i]];
    }
    [medicalDetails addObject:reminders];
    [self.medication.drugImage getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        self.drugImage.image=[UIImage imageWithData:data];
    }];
}

- (IBAction)Save:(id)sender {
    if(self.medication){
        DEDataHandler *handler=[[DEDataHandler alloc] init];
        [handler saveMyMedication:self.medication];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma  -mark TableView Delagate and Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}


-(UITableViewCell *) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"confirmCell";
    DEConfirmViewCell *cell =(DEConfirmViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.headLabel.text=[sectionHeaders objectAtIndex:indexPath.row];
    cell.dataLabel.text=[medicalDetails objectAtIndex:indexPath.row];
    cell.dataLabel.numberOfLines = 0;
    [cell.dataLabel sizeToFit];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
