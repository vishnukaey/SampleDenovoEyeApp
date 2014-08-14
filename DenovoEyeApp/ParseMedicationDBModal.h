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
@property (strong,nonatomic) NSString *frequency;
@property (strong,nonatomic) NSString *reccurence;
@property (weak,nonatomic) NSData *drugImageData;
@property (nonatomic, retain) id reminder;

@end
