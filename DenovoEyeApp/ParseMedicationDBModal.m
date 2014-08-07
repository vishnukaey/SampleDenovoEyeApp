//
//  ParseMedicationDBModal.m
//  DenovoEyeApp
//
//  Created by qbadmin on 06/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "ParseMedicationDBModal.h"

@implementation ParseMedicationDBModal

@dynamic drugImage;
@dynamic drugName;
@dynamic expiryDate;

+ (NSString *) parseClassName{
    return @"Medication";
}
@end
