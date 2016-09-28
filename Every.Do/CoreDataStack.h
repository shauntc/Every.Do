//
//  CoreDataStack.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (nonatomic) NSManagedObjectContext *context;

+ (id)sharedManager;


@end
