//
//  addToDoViewController.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo+CoreDataClass.h"
#import "ToDoSaveProtocol.h"

@interface AddToDoViewController : UIViewController

@property (nonatomic, assign) BOOL cancel;
@property (nonatomic) ToDo *toDo;
@property (nonatomic, weak) id<ToDoSaveProtocol> delegate;

- (instancetype)initWithToDo:(ToDo*)toDo;


@end
