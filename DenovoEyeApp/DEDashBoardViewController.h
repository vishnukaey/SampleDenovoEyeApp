//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.

#import <UIKit/UIKit.h>
#import <MSSimpleGauge/MSAnnotatedGauge.h>


@interface DEDashBoardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *dashBoardTableView;
@property (weak, nonatomic) IBOutlet UITableView *dashBoardMenuTable;
@property (nonatomic) MSAnnotatedGauge *annotatedGauge;
@end
