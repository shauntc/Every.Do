//
//  MasterViewController.m
//  Every.Do
//
//  Created by Shaun Campbell on 2016-09-20.
//  Copyright © 2016 Shaun Campbell. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ToDo+CoreDataClass.h"
#import "ToDoTableViewCell.h"
#import "addToDoViewController.h"
#import "CoreDataStack.h"

@interface MasterViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic) NSMutableArray<ToDo*> *toDos;
//@property (nonatomic) NSIndexPath *selectedIndex;
//@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic) UISwipeGestureRecognizer *swipeRecogizer;
@property (nonatomic) CoreDataStack *stack;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.stack = [CoreDataStack sharedManager];
    NSFetchRequest *tdfr = [ToDo fetchRequest];
    
    //Edit fetch requests
    tdfr.fetchLimit = 100;
    NSSortDescriptor *sortPriority = [NSSortDescriptor sortDescriptorWithKey:@"priorityNumber" ascending:YES];
    NSSortDescriptor *sortDueDate = [NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES];
    
    tdfr.sortDescriptors = @[sortDueDate, sortPriority];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:tdfr managedObjectContext:self.stack.context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewToDo:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
    
//    self.toDos = [[NSMutableArray alloc] init];
//    
//    [self.toDos addObject:[[ToDo alloc] initWithTitle:@"Every.Do" andDescription:@"This exact Project which I need to complete but I want this string to be long" andPriority:1]];
//    [self.toDos addObject:[[ToDo alloc] initWithTitle:@"Weather App" andDescription:@"The other Project which I need to complete but I want this string to be long" andPriority:3]];
//    [self.toDos addObject:[[ToDo alloc] initWithTitle:@"Midterm App" andDescription:@"The midterm app Project which I need to complete but I want this string to be long" andPriority:1]];
//    [self.toDos addObject:[[ToDo alloc] initWithTitle:@"Midterm Exam" andDescription:@"The midterm exam which I need to complete but I want this string to be long" andPriority:2]];
//    [self.toDos addObject:[[ToDo alloc] initWithTitle:@"Image Gallery App" andDescription:@"Image gallery app from the yesterday which I need to complete but I want this string to be long" andPriority:1]];
//    
//    self.toDos[1].isComplete = YES;
//    self.toDos[4].isComplete = YES;
    
    self.title = @"To Do List";
    
    self.swipeRecogizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureOccured:)];
    
    [self.tableView addGestureRecognizer:self.swipeRecogizer];
  
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewToDo:(id)sender {
    if (!self.toDos) {
        self.toDos = [[NSMutableArray alloc] init];
    }
    
    [self performSegueWithIdentifier:@"addToDoSegue" sender:self];
     
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setToDo:object];
    }
    else if( [[segue identifier] isEqualToString:@"addToDoSegue"])
    {
        ToDo *new = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo" inManagedObjectContext:self.stack.context];

        addToDoViewController *newVC = (addToDoViewController*)[segue destinationViewController];
        newVC.toDo = new;
        
        
    }
}






#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.toDos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoTableViewCell" forIndexPath:indexPath];

    ToDo *todo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [self configureCell:cell withTodo:todo];
    
    return cell;
}

-(void)configureCell:(ToDoTableViewCell *)cell withTodo:(ToDo *)object
{
    cell.toDo = object;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    ToDo *temp = self.toDos[sourceIndexPath.row];
    [self.toDos removeObjectAtIndex:sourceIndexPath.row];
    [self.toDos insertObject:temp atIndex:destinationIndexPath.row];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.toDos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}








- (void)swipeGestureOccured:(UISwipeGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateRecognized)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
        
        self.toDos[indexPath.row].isComplete = !self.toDos[indexPath.row].isComplete;
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
    
    
}


#pragma mark - FechedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] withTodo:anObject];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}





@end
