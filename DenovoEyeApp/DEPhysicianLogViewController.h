//
//  DEPhysicianLogViewController.h
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEPhysicianLogViewController : UIViewController
@property (assign, nonatomic ) DEParsePhysicianModel *physician;
@property (weak, nonatomic) IBOutlet UILabel *physicianName;
@property (weak, nonatomic) IBOutlet UIButton *makeAnAppointment;
@property (weak, nonatomic) IBOutlet UITableView *appointmentHistory;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@end
