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
                                              entityForName:@"Entity2" inManagedObjectContext:moc];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    NSError *error;
    array=[moc executeFetchRequest:request error:&error];
    NSMutableArray *mutableArray=[[NSMutableArray alloc]init];
    for (Entity *entity in array) {
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
            if(!(entity.drugImage == nil) && !(entity.drugName == nil)){
                [dict setObject:entity.drugName forKey:@"drugName"];
                [dict setObject:entity.drugImage forKey:@"drugImage"];
                [dict setObject:entity.reccurence forKey:@"reccurence"];
                [dict setObject:entity.frequency forKey:@"frequency"];
                [dict setObject:entity.reminder forKey:@"reminder"];
                if(entity.appointment != Nil)
                [dict setObject:entity.appointment forKey:@"appointment"];
                [mutableArray addObject:dict];
            }
    }
    return mutableArray;
}

-(void) saveMyMedication:(id)medication{
    if([self notAnExistingMedication:medication]){
        NSManagedObjectContext *context = [self managedObjectContext];
        NSError *error;
        ParseMedicationDBModal *modal=[[ParseMedicationDBModal alloc]init];
        modal=medication;
        NSManagedObject *newContact;
        newContact = [NSEntityDescription insertNewObjectForEntityForName:@"Entity2"
                                               inManagedObjectContext:context];
        [newContact setValue:modal.drugName forKey:@"drugName"];
        [newContact setValue:[modal.drugImage getData] forKey:@"drugImage"];
        [newContact setValue:modal.reminder forKey:@"reminder"];
        [newContact setValue:modal.frequency forKey:@"frequency"];
        [newContact setValue:modal.reccurence forKey:@"reccurence"];
        [newContact setValue:modal.appointment forKey:@"appointment"];
        [context save:&error];
    }
}

-(bool)notAnExistingMedication:(id)medication{
    NSArray *checkMedicationList=[[NSArray alloc]init];
    checkMedicationList=[self getMedicationList];
    ParseMedicationDBModal *modal=[[ParseMedicationDBModal alloc]init];
    modal=medication;
    int flag=1;
    for(int i=0;  i <  checkMedicationList.count; i++)
    {
        if([[[checkMedicationList objectAtIndex:i] valueForKey:@"drugName"] isEqualToString:modal.drugName])
        {
            flag=0;
            break;
        }
    }
    if(flag==1)
        return YES;
    else
        return NO;
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
