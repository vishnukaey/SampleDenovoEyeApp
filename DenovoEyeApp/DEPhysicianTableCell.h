//
//  DEPhysicianTableCell.h
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEPhysicianTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *physicianImage;
@property (weak, nonatomic) IBOutlet UILabel *physicianName;
@property (weak, nonatomic) IBOutlet UILabel *physicianSpecialisation;
@property (weak, nonatomic) IBOutlet UILabel *physicianAddress;
@end
