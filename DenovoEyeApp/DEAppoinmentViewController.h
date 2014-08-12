//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEAppoinmentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *skipToConfirm;
@property (assign, nonatomic ) ParseMedicationDBModal *medication;

@end
