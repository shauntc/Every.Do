//
//  MasterViewController.h
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataStack.h"

@class DetailViewController;

@interface MasterViewController : UITableViewController


@property (nonatomic) CoreDataStack *stack;



@end

