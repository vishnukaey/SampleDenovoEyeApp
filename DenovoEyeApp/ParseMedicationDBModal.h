//
//  ParseMedicationDBModal.h
//  DenovoEyeApp
//
//  Created by qbadmin on 06/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/PFObject+Subclass.h>
#import <Parse/Parse.h>

@interface ParseMedicationDBModal : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (weak, nonatomic) NSString *drugName;
@property (weak,nonatomic) PFFile *drugImage;
@property (weak,nonatomic) NSString *expiryDate;
@property (weak,nonatomic) NSString *frequency;
@property (weak,nonatomic) NSString *reccurence;
@property (strong,nonatomic) NSMutableArray *reminder;
@property (strong,nonatomic) NSMutableArray *appointment;
@end
