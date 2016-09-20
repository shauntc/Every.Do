//
//  ToDo.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *toDoDescription;
@property (nonatomic, assign) int priorityNumber;
@property (nonatomic, assign) BOOL isComplete;

-(instancetype)initWithTitle:(NSString*)title andDescription:(NSString*)description andPriority:(int)priority;

@end
