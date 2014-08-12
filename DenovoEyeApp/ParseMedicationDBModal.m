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
@dynamic frequency;
@dynamic reccurence;
@dynamic reminder;
@dynamic appointment;

+ (NSString *) parseClassName{
    return @"Medication";
}

@end
