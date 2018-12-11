//
//  CoreDataStack.m
//  TinkoffChat
//
//  Created by st.i on 07/12/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack () {
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
    NSManagedObjectContext *_masterContext; //взаимодействует с NSPersistentStoreCoordinator
    NSManagedObjectContext *_mainContext; //отображает данные на экране
    NSManagedObjectContext *_saveContext; //получает и парсит данные
}

@property (readonly, strong) NSURL *storeURL;
@property (readonly, copy) NSString *managedObjectModelName;
@property (readonly, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong) NSManagedObjectContext *masterContext;

@end

@implementation CoreDataStack

- (NSURL *)storeURL {
    NSURL *documentsDirURL = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    NSURL *url = [documentsDirURL URLByAppendingPathComponent:@"Store.sqlite"];
    return url;
}

- (NSString *)managedObjectModelName {
    return @"Storage";
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel == nil) {
        NSURL *modelURL = [NSBundle.mainBundle URLForResource:self.managedObjectModelName withExtension:@"momd"];
        if (modelURL == nil) {
            return nil;
        }else{
            return _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        }
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator == nil) {
        if (self.managedObjectModel == nil) {
            NSLog(@"Empty managed object model!");
            return nil;
        }else{
            _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
            @try {
                [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storeURL options:nil error:nil];
            } @catch (NSException *exception) {
                NSString *errorString = [NSString stringWithFormat:@"Error during process of adding persistent store to coordinator: %@", exception.userInfo];
                NSAssert(NO, errorString);
            } @finally {
                NSLog(@"Process of adding persistent store to coordinator was finished");
            }
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)masterContext {
    if (_masterContext == nil) {
        NSManagedObjectContext *newContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        if (self.persistentStoreCoordinator == nil) {
            NSLog(@"Empty persistent store coordinator!");
            return nil;
        }else{
            newContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
            newContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
            newContext.undoManager = nil;
            _masterContext = newContext;
        }
    }
    return _masterContext;
}

- (NSManagedObjectContext *)mainContext {
    if (_mainContext == nil) {
        NSManagedObjectContext *newContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        if (self.masterContext == nil) {
            NSLog(@"No master context!");
            return nil;
        }else{
            newContext.parentContext = self.masterContext;
            newContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy;
            newContext.undoManager = nil;
            _mainContext = newContext;
        }
    }
    return _mainContext;
}

- (NSManagedObjectContext *)saveContext {
    if (_saveContext == nil) {
        NSManagedObjectContext *newContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        if (self.mainContext == nil) {
            NSLog(@"No master context!");
            return nil;
        }else{
            newContext.parentContext = self.mainContext;
            newContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
            newContext.undoManager = nil;
            _saveContext = newContext;
        }
    }
    return  _saveContext;
}

- (void)performSaveInContext:(NSManagedObjectContext *)context withCompletionHandler:(void (^)(void))completionHandler {
    if (context.hasChanges) {
        __weak CoreDataStack *weakSelf = self;
        [context performBlock:^{
            @try {
                [context save:nil];
            } @catch (NSException *exception) {
                NSLog(@"Context saving error: %@", exception.userInfo);
            } @finally {
                NSLog(@"Context saving process was finished!");
            }
            
            if (context.parentContext == nil) {
                completionHandler();
            }else{
                [weakSelf performSaveInContext:context.parentContext withCompletionHandler:completionHandler];
            }
        }];
    }else{
        completionHandler();
    }
}

@end
