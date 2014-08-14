//
//  Appoinment.h
//  DenovoEyeApp
//
//  Created by Vishnu on 14/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Appoinment : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * provider;
@property (nonatomic, retain) NSString * time;

@end
