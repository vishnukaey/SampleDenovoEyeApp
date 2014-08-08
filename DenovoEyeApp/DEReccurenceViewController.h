//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEReccurenceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIPickerView *recurrencePicker;
@property (weak, nonatomic) IBOutlet UILabel *recurrenceLabel;
@property (weak, nonatomic) IBOutlet UILabel *frequencyLabel;
@property (assign, nonatomic ) ParseMedicationDBModal *medication;
@end
