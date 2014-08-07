//
//  Entity.h
//  DenovoEyeApp
//
//  Created by qbadmin on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSString * drugName;
@property (nonatomic, retain) NSData * drugImage;

@end
