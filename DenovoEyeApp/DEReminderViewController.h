//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEReminderViewController : UIViewController<UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *reminderView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextToAppoinments;
@property (assign, nonatomic ) ParseMedicationDBModal *medication;
@end
