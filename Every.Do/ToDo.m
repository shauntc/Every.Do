//
//  ToDo.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "ToDo.h"



@implementation ToDo






-(instancetype)initWithTitle:(NSString*)title andDescription:(NSString*)description andPriority:(int)priority
{
    self = [super init];
    if (self) {
        _title = title;
        _toDoDescription = description;
        _priorityNumber = priority;
        _isComplete = NO;
        _dueDate = nil;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithTitle:@"Default" andDescription:@"The default initialization" andPriority:10];
}

@end
