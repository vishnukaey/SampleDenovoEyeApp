//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DEDataHandler.h"

@interface DEConfirmViewController : UIViewController
@property (weak, nonatomic ) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic ) IBOutlet UIButton *confirm;
@property (weak, nonatomic ) IBOutlet UIButton *cancel;
@property (assign, nonatomic ) ParseMedicationDBModal *medication;
@end
