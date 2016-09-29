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
#import "ToDoSaveProtocol.h"

@interface MasterViewController () <NSFetchedResultsControllerDelegate, UINavigationControllerDelegate, ToDoSaveProtocol>

//@property (nonatomic) NSMutableArray<ToDo*> *toDos;
//@property (nonatomic) NSIndexPath *selectedIndex;
//@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeRecognizer;
@property (nonatomic) UISwipeGestureRecognizer *swipeRecogizer;
@property (nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //set up the the Core data stack
    self.stack = [CoreDataStack sharedManager];
    NSFetchRequest *tdfr = [ToDo fetchRequest];
    
    //Edit fetch requests
    tdfr.fetchLimit = 100;
    NSSortDescriptor *sortPriority = [NSSortDescriptor sortDescriptorWithKey:@"priorityNumber" ascending:YES];
    NSSortDescriptor *sortDueDate = [NSSortDescriptor sortDescriptorWithKey:@"dueDate" ascending:YES];
    
    tdfr.sortDescriptors = @[sortDueDate, sortPriority];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:tdfr managedObjectContext:self.stack.context sectionNameKeyPath:nil cacheName:nil];
    self.fetchedResultsController.delegate = self;
    
    NSError *fetchError = nil;
    [self.fetchedResultsController performFetch:&fetchError];
    if(fetchError)
    {
        NSLog(@"Fetch Error: %@", fetchError);
    }
    
    
    
    
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewToDo:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"To Do List";
    
    self.swipeRecogizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureOccured:)];
    
    [self.tableView addGestureRecognizer:self.swipeRecogizer];
  
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)insertNewToDo:(UIBarButtonItem *)sender
{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    AddToDoViewController *addView = [mainStoryboard instantiateViewControllerWithIdentifier:@"addToDoViewController"];
    
    addView.toDo = [NSEntityDescription insertNewObjectForEntityForName:@"ToDo" inManagedObjectContext:self.stack.context];
    addView.delegate = self;
    
    [self.navigationController showViewController:addView sender:self];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ToDo *object = [self.fetchedResultsController objectAtIndexPath:indexPath];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        controller.delegate = self;
        [controller setToDo:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)swipeGestureOccured:(UISwipeGestureRecognizer *)sender {
    if(sender.state == UIGestureRecognizerStateRecognized)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:[sender locationInView:self.tableView]];
        
        ToDo *todo = [self.fetchedResultsController objectAtIndexPath:indexPath];
        todo.isComplete = !todo.isComplete;
        
        NSError *saveError = nil;
        
        [self.stack.context save:&saveError];
        if(saveError)
        {
            NSLog(@"swipeGestureOccured: Error saving context: %@", saveError);
        }
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self deleteToDo:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self insertNewToDo:nil];
    }
}


#pragma mark - ToDoSaveProtocol

-(void)SaveToDo:(ToDo *)todo
{
    NSError *saveError = nil;
    
    [self.stack.context save:&saveError];
    if(saveError)
    {
        NSLog(@"\nSave Error: %@ \nFor ToDo: %@", saveError, todo);
    }
}

-(void)deleteToDo:(ToDo *)todo
{
    if(todo)
    {
        [self.stack.context deleteObject:todo];
        [self SaveToDo:nil];
    }
    else{
        NSLog(@"Error: ToDo was Nil");
    }
}

-(void)undoToDo:(ToDo *)todo
{
    [self.stack.context undo];
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
