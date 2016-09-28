//
//  ToDo+CoreDataProperties.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "ToDo+CoreDataProperties.h"

@implementation ToDo (CoreDataProperties)

+ (NSFetchRequest<ToDo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ToDo"];
}

@dynamic title;
@dynamic toDoDescription;
@dynamic dueDate;
@dynamic priorityNumber;
@dynamic isComplete;

@end
