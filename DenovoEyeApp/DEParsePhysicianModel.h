//
//  DEParsePhysicianModel.h
//  DenovoEyeApp
//
//  Created by Vishnu on 13/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/PFObject+Subclass.h>
#import <Parse/Parse.h>

@interface DEParsePhysicianModel : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (weak, nonatomic) NSString *name;
@property (weak,nonatomic) PFFile *photo;
@property (weak,nonatomic) NSString *qualification;
@property (weak,nonatomic) NSString *specialisation;
@property (weak,nonatomic) NSString *address;

@end
