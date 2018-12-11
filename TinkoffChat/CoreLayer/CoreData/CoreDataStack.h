//
//  CoreDataStack.h
//  TinkoffChat
//
//  Created by st.i on 07/12/2018.
//  Copyright © 2018 Иван Стефанов. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreDataStack : NSObject

@property (readonly, strong) NSManagedObjectContext *mainContext;
@property (readonly, strong) NSManagedObjectContext *saveContext;

- (void)performSaveInContext:(NSManagedObjectContext *)context withCompletionHandler:(void (^)(void))completionHandler;

@end

NS_ASSUME_NONNULL_END
