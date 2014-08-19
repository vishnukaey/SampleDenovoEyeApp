//
//  DEOCPCell.h
//  DenovoEyeApp
//
//  Created by Vishnu on 19/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DEOCPCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ocpStatusLabelRight;
@property (weak, nonatomic) IBOutlet UILabel *ocpStatusLabelLeft;
@property (weak, nonatomic) IBOutlet UILabel *ocpValueRight;
@property (weak, nonatomic) IBOutlet UILabel *ocpValueLeft;
@end
