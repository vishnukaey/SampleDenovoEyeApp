//
//  DEParsePhysicianModel.m
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEParsePhysicianModel.h"
@implementation DEParsePhysicianModel
@dynamic name;
@dynamic photo;
@dynamic qualification;
@dynamic specialisation;
@dynamic address;

+ (NSString *) parseClassName{
    return @"Physician";
}

@end
