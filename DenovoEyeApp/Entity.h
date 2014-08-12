//
//  Entity.h
//  DenovoEyeApp
//
//  Created by Vishnu on 12/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) id appointment;
@property (nonatomic, retain) NSData * drugImage;
@property (nonatomic, retain) NSString * drugName;
@property (nonatomic, retain) NSString * frequency;
@property (nonatomic, retain) NSString * reccurence;
@property (nonatomic, retain) id reminder;

@end
