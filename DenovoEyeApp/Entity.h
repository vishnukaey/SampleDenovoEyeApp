//
//  Entity.h
//  DenovoEyeApp
//
//  Created by Vishnu on 14/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, strong) NSData * drugImage;
@property (nonatomic, strong) NSString * drugName;
@property (strong,nonatomic) NSString *frequency;
@property (strong,nonatomic) NSString *reccurence;
@property (nonatomic, retain) id reminder;
@end
