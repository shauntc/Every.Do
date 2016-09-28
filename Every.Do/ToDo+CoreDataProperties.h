//
//  ToDo+CoreDataProperties.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "ToDo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ToDo (CoreDataProperties)

+ (NSFetchRequest<ToDo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *toDoDescription;
@property (nullable, nonatomic, copy) NSDate *dueDate;
@property (nonatomic) int32_t priorityNumber;
@property (nonatomic) BOOL isComplete;

@end

NS_ASSUME_NONNULL_END
