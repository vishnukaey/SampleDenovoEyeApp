//
//  DEDataHandler.h
//  DenovoEyeApp
//
//  Created by qbadmin on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DEDataHandler : NSObject

    @property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
    @property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
    @property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

    - (NSURL *)applicationDocumentsDirectory;

    -(void) saveMyMedication:(id)medication;
    -(void)saveAppointment:(NSDictionary*)appointment;

    -(NSArray*) getMedicationList;
    -(NSArray *) getAllAppoinments;

    -(id) initialize;
    -(id) insertToAppointments;

@end
