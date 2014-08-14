//
//  DEAppoinmentsAddNewViewController.h
//  DenovoEyeApp
//
//  Created by Vishnu on 14/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEAppoinmentsAddNewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *physicianName;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (assign,nonatomic) NSString *physician;
@end
