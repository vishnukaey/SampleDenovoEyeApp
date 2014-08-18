//
//  DEMedicationCell.h
//  DenovoEyeApp
//
//  Created by qbadmin on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEMedicationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *drugImage;
@property (weak, nonatomic) IBOutlet UILabel *drugName;
@property (weak, nonatomic) IBOutlet UILabel *medicationDealer;
@property (weak, nonatomic) IBOutlet UILabel *medicationDealerContact;
@property (weak, nonatomic) IBOutlet UILabel *medicationPrescription;
@property (weak, nonatomic) IBOutlet UILabel *expiryDate;
@end
