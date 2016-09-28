//
//  addToDoViewController.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo+CoreDataClass.h"

@interface addToDoViewController : UIViewController

@property (nonatomic) ToDo *toDo;

- (instancetype)initWithToDo:(ToDo*)toDo;


@end
