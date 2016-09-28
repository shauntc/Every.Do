//
//  CoreDataStack.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "CoreDataStack.h"

@implementation CoreDataStack


+ (id)sharedManager
{
    static CoreDataStack *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURL *dataStackURL = [[NSBundle mainBundle] URLForResource:@"Every.Do" withExtension:@"momd"];
        NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:dataStackURL];
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
        
        NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentDirectories firstObject];
        NSURL *dbURL = [NSURL fileURLWithPath:[documentsPath stringByAppendingString:@"ToDoList.b"]];
        
        NSError *pscError = nil;
        if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:dbURL options:nil error:&pscError])
        {
            NSLog(@"Error creating psc: %@", pscError);
        }
        
        _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_context setPersistentStoreCoordinator:psc];
    }
    return self;
}



@end
