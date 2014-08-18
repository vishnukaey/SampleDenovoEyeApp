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
#import "DEMedicationCell.h"

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
//    [self addLocalNotification];
}



//-(void) addLocalNotification{
//    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
//    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
//    localNotification.alertBody = @"Your alert message";
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
//}



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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == self.dashBoardMenuTable)
        return menuItems.count;
    else
        return myMedicationList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.dashBoardMenuTable){
        static NSString *CellIdentifier = @"menuItem";
        DEMenuListItem *cell =(DEMenuListItem *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.menuListItem.text=[menuItems objectAtIndex:indexPath.row];
        return cell;
    }else
    {
        static NSString *CellIdentifier = @"medication";
        DEMedicationCell *cell =(DEMedicationCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.drugName.text=[[myMedicationList objectAtIndex:indexPath.row] valueForKey:@"drugName"];
        cell.drugImage.image=[UIImage imageWithData:[[myMedicationList objectAtIndex:indexPath.row] valueForKey:@"drugImage"]];
        return cell;

    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.dashBoardMenuTable){
        [self performSegueWithIdentifier:[menuItems objectAtIndex:indexPath.row] sender:self];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
