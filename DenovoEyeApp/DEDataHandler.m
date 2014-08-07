//
//  DEDataHandler.m
//  DenovoEyeApp
//
//  Created by qbadmin on 07/08/14.
//  Copyright (c) 2014 Vishnu. All rights reserved.
//

#import "DEDataHandler.h"

@implementation DEDataHandler

    @synthesize managedObjectContext = _managedObjectContext;
    @synthesize managedObjectModel = _managedObjectModel;
    @synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(id) init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

-(NSArray*) getMedicationList{
    NSArray *array=[[NSArray alloc]init];
    NSManagedObjectContext *moc = [self managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Entity" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    array=[moc executeFetchRequest:request error:&error];
    NSMutableArray *mutableArray=[[NSMutableArray alloc]init];
    for (Entity *entity in array) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:entity.drugName forKey:@"drugName"];
        [dict setObject:entity.drugImage forKey:@"drugImage"];
        [mutableArray addObject:dict];
    }
    return mutableArray;
}

-(void) saveMyMedication:(id)medication{
    NSManagedObjectContext *context =
    [self managedObjectContext];
    NSError *error;
    ParseMedicationDBModal *modal=[[ParseMedicationDBModal alloc]init];
    modal=medication;
    NSManagedObject *newContact;
    newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Entity"
                                               inManagedObjectContext:context];
    [newContact setValue:modal.drugName forKey:@"drugName"];
    [newContact setValue:[modal.drugImage getData] forKey:@"drugImage"];
    [context save:&error];
}

- (NSManagedObjectContext *) managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    NSURL *storeUrl =[[self applicationDocumentsDirectory]
                      URLByAppendingPathComponent: @"Entity.sqlite"];
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]
                                   initWithManagedObjectModel:[self managedObjectModel]];
    if(![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                  configuration:nil URL:storeUrl options:nil error:&error]) {
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
