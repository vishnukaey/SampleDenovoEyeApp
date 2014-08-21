//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEDashBoardViewController.h"
#import "DEMenuListItem.h"
#import "DELoginViewController.h"
#import "DEMedicationComplianceCell.h"
#import "DEOCPCell.h"

@interface DEDashBoardViewController (){
    NSArray *menuItems;
    NSArray *myMedicationList;
}

@end

@implementation DEDashBoardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    menuItems=[[NSArray alloc]initWithObjects:
               @"MEDICATION",@"APPOINMENTS",@"OCULAR PRESSURE",@"REWARDS",@"TIMELINE",
               @"SETTINGS",@"HELP",@"TERMS & CONDITIONS", nil];
    [self performSegueWithIdentifier:@"welcome" sender:self];
}



-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    DEDataHandler *handler=[[DEDataHandler alloc]init];
    myMedicationList=[handler getMedicationList];
    [self.dashBoardTableView reloadData];
}



- (IBAction)viewMenuList:(id)sender {
    static bool menuViewShown=NO;
    menuViewShown=!menuViewShown;
    [self showMenuItemTable:menuViewShown];
}



-(void) showMenuItemTable:(bool)shouldshow{
    int offset;
    if(shouldshow)
        offset=self.dashBoardMenuTable.frame.size.width;
    else
        offset=-self.dashBoardMenuTable.frame.size.width;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    CGRect dashBoardframe = self.dashBoardTableView.frame;
    dashBoardframe.origin.x += offset;
    self.dashBoardTableView.frame = dashBoardframe;
    CGRect menuListFrame = self.dashBoardMenuTable.frame;
    menuListFrame.origin.x += offset;
    self.dashBoardMenuTable.frame = menuListFrame;
    [UIView commitAnimations];
}



- (IBAction)logout:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"loginStatus"];
    [defaults synchronize];
    [self performSegueWithIdentifier:@"login" sender:self];
}




-(void) viewWillDisappear:(BOOL)animated{
    if(self.dashBoardMenuTable.frame.origin.x==0)
        [self viewMenuList:Nil];
}




#pragma -mark TableView Delagate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     if(tableView == self.dashBoardTableView)
         return 2;
    else
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.dashBoardMenuTable)
        return menuItems.count;
    else{
        if(section == 0)
            return myMedicationList.count;
        else
            return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.dashBoardMenuTable){
        static NSString *CellIdentifier = @"menuItem";
        DEMenuListItem *cell =(DEMenuListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.menuListItem.text=[menuItems objectAtIndex:indexPath.row];
        return cell;
    }
    
    else{
        if(indexPath.section == 0){
            static NSString *CellIdentifier = @"medication";
            DEMedicationComplianceCell *cell =(DEMedicationComplianceCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            cell.label.text=[[myMedicationList objectAtIndex:indexPath.row] valueForKey:@"drugName"];
            SFGaugeView *meterView =[self getMeterView:20];
            [cell.meterContainer addSubview:meterView];
            return cell;
            }
        else{
            static NSString *CellIdentifier = @"ocp";
            DEOCPCell *cell =(DEOCPCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            int ocpValueLeft=3, ocpValueRight=14;
            cell.ocpValueLeft.text=[NSString stringWithFormat:@"%d",ocpValueLeft];
            cell.ocpValueRight.text=[NSString stringWithFormat:@"%d",ocpValueRight];
            cell.ocpStatusLabelLeft.text = [self getStatusBasedOnOcpValue:ocpValueLeft];
            cell.ocpStatusLabelRight.text = [self getStatusBasedOnOcpValue:ocpValueRight];
            cell.ocpStatusLabelLeft.textColor=[self getColourBasedOnStatus:cell.ocpStatusLabelLeft.text];
            cell.ocpStatusLabelRight.textColor=[self getColourBasedOnStatus:cell.ocpStatusLabelRight.text];
            return cell;
        }
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.dashBoardMenuTable){
        [self performSegueWithIdentifier:[menuItems objectAtIndex:indexPath.row] sender:self];
    }
}



-(NSString * )getStatusBasedOnOcpValue:(int)ocpValue{
    if(ocpValue >15)
        return @"HIGH";
    else if(ocpValue > 10)
        return @"NORMAL";
    else
        return @"LOW";
}



-(UIColor *) getColourBasedOnStatus:(NSString *)status{
    UIColor *red,*green;
    red = [UIColor redColor];
    green = [UIColor greenColor];
    if([status isEqualToString:@"HIGH"] || [status isEqualToString:@"LOW"])
        return red;
    else
        return green;
}



-(SFGaugeView *)getMeterView:(NSInteger) currentValue{
    SFGaugeView *meterView = [[SFGaugeView alloc] initWithFrame:CGRectMake(70, 5, 160, 95)];
    meterView.maxlevel=100;
    meterView.minlevel=0;
    meterView.needleColor = [UIColor brownColor];
    meterView.currentLevel=currentValue;
    meterView.userInteractionEnabled=NO;
    meterView.bgColor = [UIColor  lightGrayColor];
    return meterView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
