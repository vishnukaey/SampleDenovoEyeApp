//
//  Appoinment.h
//  Pods
//
//  Created by Vishnu on 11/08/14.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Appoinment : NSManagedObject

@property (nonatomic, retain) NSString * provider;
@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSString * time;

@end
