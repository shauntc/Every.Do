//
//  ToDoSaveProtocol.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-28.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDo+CoreDataClass.h"

@protocol ToDoSaveProtocol <NSObject>

-(void)SaveToDo:(ToDo *)todo;
-(void)deleteToDo:(ToDo *)todo;

@optional
-(void)undoToDo:(ToDo *)todo;

@end
