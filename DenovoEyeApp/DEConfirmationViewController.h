//
//  DEConfirmationViewController.m
//  DenovoEyeApp
//
//  Created by Vishnu on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.


#import <UIKit/UIKit.h>

@interface DEConfirmationViewController : UIViewController
@property (assign, nonatomic ) ParseMedicationDBModal *medication;
@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@end
